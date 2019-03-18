Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0EBC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 22:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447F52171F
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 22:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552947642;
	bh=itER1yVNjfjm0wcssDYY0/CbNE+Tp0IW0c8cAwU2f18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JpgaIbq7YhM/sW2dS6UYJ+OT9zHeyWXdFW/TrSOFV0nCUXxRucASPsHY8+pT3xO17
	 CGklGS4shjji1NEbBZHqnDKPNGPb/GHi3EnfT/aerhnmsr1iYWX/Sj3j3BURXlhSd1
	 ownPDsg12jwbQhCRKyXcHc0UOYrZ7Fpg6/PprsHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfCRWUl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 18:20:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:17030 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfCRWUl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 18:20:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 15:20:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,495,1544515200"; 
   d="scan'208";a="128086212"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga006.jf.intel.com with ESMTP; 18 Mar 2019 15:20:40 -0700
Date:   Mon, 18 Mar 2019 16:21:34 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Nikhil Sambhus <nikhilsambhus@gmail.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: Error while enabling io_poll for NVMe SSD
Message-ID: <20190318222133.GA24176@localhost.localdomain>
References: <CAFQ9A4Zc8Fc4bDyAsiduTw4kTpxR=dVZr7LUdqUkvQSu1CaGpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFQ9A4Zc8Fc4bDyAsiduTw4kTpxR=dVZr7LUdqUkvQSu1CaGpg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 18, 2019 at 06:14:01PM -0400, Nikhil Sambhus wrote:
> Hi,
> 
> On a Linux Kernel 5.0.0+ machine (Ubuntu 16.04)  I am using the
> following command as a root user to enable polling for a NVMe SSD
> device.
> 
> # echo 1 > /sys/block/nvme2n1/queue/io_poll
> 
> I get the following error:
> 
> bash: echo: write error: Invalid argument
> 
> The current value of io_poll is 0.

Be sure to turn on the polling queues in the nvme driver. There are none
by default. The kernel parameter to that enable them is:

  nvme.poll_queues=X

Where 'X' is the number of polling queues. I'd recommend at least 1 per
CPU socket, but more is better.
