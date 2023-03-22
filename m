Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AF0C6FD1C
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 11:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCVLIe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 07:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCVLI2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 07:08:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B177C30CA
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 04:08:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 471A133A2E;
        Wed, 22 Mar 2023 11:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1679483306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eOGdcO1EZD9n5IqMHjs3eG75QoqO37wM75r0PcRnhsE=;
        b=TJGJQb1KcF1EzjdmPNM+Rysb2Afw8R8rs19Du6PRIL9gtVr39Y8NuvFTIBHy28OPdSwpA5
        Hy+h9A+Lo/LbCDveXFnem91qEVLqKtn7lbkkniqFyz50/hFrH/imjnQo8gPTGqYl2jz5yC
        N4IM0OFh+QQ8urQ670gVP1SvsUip+34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1679483306;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eOGdcO1EZD9n5IqMHjs3eG75QoqO37wM75r0PcRnhsE=;
        b=tnrAgcXyTos48Pm9+N8iijpdW8lVrKAtqFySqLco1v/3GGXzKIVHTHv9+xUPqvMy9Ot3k2
        tCHKFTWfO/khekDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3AD97138E9;
        Wed, 22 Mar 2023 11:08:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id r8hRDqrhGmRqKgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 22 Mar 2023 11:08:26 +0000
Date:   Wed, 22 Mar 2023 12:08:25 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v2 1/3] nvme/rc: Parse optional arguments in
 _nvme_connect_subsys()
Message-ID: <20230322110825.333gezvuiaf7gof3@carbon.lan>
References: <20230322101648.31514-1-dwagner@suse.de>
 <20230322101648.31514-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322101648.31514-2-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 22, 2023 at 11:16:46AM +0100, Daniel Wagner wrote:
> +			-S|--dhchap-secret)
> +				hostkey="$2"
> +				shift
> +				shift
> +				;;
> +			-C|--dhchap-ctrl-sectret)

Urgh, typo. I wonder why I didn't caught this in my first round of testing.
