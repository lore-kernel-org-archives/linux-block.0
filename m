Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3845C00140
	for <linux-block@archiver.kernel.org>; Wed, 10 Aug 2022 13:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiHJNRU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Aug 2022 09:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiHJNRB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Aug 2022 09:17:01 -0400
X-Greylist: delayed 1314 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 Aug 2022 06:16:57 PDT
Received: from bout01.mta.xmission.com (bout01.mta.xmission.com [166.70.11.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFE6220FC
        for <linux-block@vger.kernel.org>; Wed, 10 Aug 2022 06:16:57 -0700 (PDT)
Received: from mx03.mta.xmission.com ([166.70.13.213]:47938)
        by bout01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1oLlEW-002gz0-FT; Wed, 10 Aug 2022 06:54:48 -0600
Received: from plesk14-shared.xmission.com ([166.70.198.161]:43280 helo=plesk05.xmission.com)
        by mx03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1oLlEV-00EaNV-9T; Wed, 10 Aug 2022 06:54:48 -0600
Received: from hacktheplanet (unknown [207.180.170.2])
        by plesk05.xmission.com (Postfix) with ESMTPSA id 04383656A6;
        Wed, 10 Aug 2022 12:54:45 +0000 (UTC)
Date:   Wed, 10 Aug 2022 08:54:39 -0400
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     luca.boccassi@gmail.com
Cc:     linux-block@vger.kernel.org, hch@infradead.org,
        Jonathan.Derrick@solidigmtechnology.com,
        dougmill@linux.vnet.ibm.com, brauner@kernel.org,
        gmazyland@gmail.com
Message-ID: <20220810125439.GA17977@hacktheplanet>
References: <20220810123551.18268-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810123551.18268-1-luca.boccassi@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1oLlEV-00EaNV-9T;;;mid=<20220810125439.GA17977@hacktheplanet>;;;hst=mx03.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=pass
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH v6] block: sed-opal: Add ioctl to return device status
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on mx03.mta.xmission.com)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 10, 2022 at 01:35:51PM +0100, luca.boccassi@gmail.com wrote:
> From: "dougmill@linux.vnet.ibm.com" <dougmill@linux.vnet.ibm.com>
> 
> Provide a mechanism to retrieve basic status information about
> the device, including the "supported" flag indicating whether
> SED-OPAL is supported. The information returned is from the various
> feature descriptors received during the discovery0 step, and so
> this ioctl does nothing more than perform the discovery0 step
> and then save the information received. See "struct opal_status"
> and OPAL_FL_* bits for the status information currently returned.
> 
> This is necessary to be able to check whether a device is OPAL
> enabled, set up, locked or unlocked from userspace programs
> like systemd-cryptsetup and libcryptsetup. Right now we just
> have to assume the user 'knows' or blindly attempt setup/lock/unlock
> operations.
> 
> Signed-off-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
> Tested-by: Luca Boccassi <bluca@debian.org>
> ---
> v2: https://patchwork.kernel.org/project/linux-block/patch/612795b5.tj7FMS9wzchsMzrK%25dougmill@linux.vnet.ibm.com/
> v3: resend on request, after rebasing and testing on my machine
>     https://patchwork.kernel.org/project/linux-block/patch/20220125215248.6489-1-luca.boccassi@gmail.com/
> v4: it's been more than 7 months and no alternative approach has appeared.
>     we really need to be able to identify and query the status of a sed-opal
>     device, so rebased and resending.
> v5: as requested by reviewer, add __32 reserved to the UAPI ioctl struct to align to 64
>     bits and to reserve space for future expansion
> v6: as requested by reviewer, update commit message with use case
> 
>  block/opal_proto.h            |  5 ++
>  block/sed-opal.c              | 90 ++++++++++++++++++++++++++++++-----
>  include/linux/sed-opal.h      |  1 +
>  include/uapi/linux/sed-opal.h | 13 +++++
>  4 files changed, 97 insertions(+), 12 deletions(-)

looks fine
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
