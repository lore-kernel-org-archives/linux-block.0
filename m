Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BE7C43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 18:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADEC2063F
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 18:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551898395;
	bh=N6fWbPoyhN9lHze+bA1tORGG5Az7+zYqErt0RARk54Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FIZMje9O4NnQVAhoc3T+ackH4+tIM+TCnS41rQHQvtaZEuSG8X7y5pM3n/LJ1Jdfb
	 YHYnu3DIHo6uoj8WMHqbwimKD5vu/VV61UziKsCXu/M25D6AwJrvnCiOvBkwhuBG9F
	 4Gz5uZjFZhn41jvuJ0jZ+DK+hD6Qyo98v1FAzjs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfCFSxO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:53:14 -0500
Received: from mga06.intel.com ([134.134.136.31]:42399 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfCFSxO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Mar 2019 13:53:14 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 10:53:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,448,1544515200"; 
   d="scan'208";a="152637470"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga001.fm.intel.com with ESMTP; 06 Mar 2019 10:53:12 -0800
Date:   Wed, 6 Mar 2019 11:53:41 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Alex_Gagniuc@Dellteam.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        keith.busch@intel.com
Subject: Re: Interesting 'list _add double add' with nvme drives
Message-ID: <20190306185341.GA1337@localhost.localdomain>
References: <e15de0114ffc415899aadc2d0aae418b@ausx13mps317.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e15de0114ffc415899aadc2d0aae418b@ausx13mps317.AMER.DELL.COM>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 06, 2019 at 06:48:28PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> Hi,
> 
> I'm seeing a list error when we take away, then add back a bunch of nvme 
> drives. It's not very easy to repro, and the one surviving log is pasted 
> below.

This looks like a double completion coming from the busy request
iterator. I'm suspcious it's because that iterator considers
MQ_RQ_COMPLETE requests as "started". That doesn't really make much sense,
and I can't find a single user of this interface that actually wants to
see such requests in their callbacks.

I know you said it's difficult to repro, but could you see if the
following makes it go away?

---
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 54535f4c4570..0ddcac44f912 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -659,7 +659,7 @@ EXPORT_SYMBOL(blk_mq_complete_request);
 
 int blk_mq_request_started(struct request *rq)
 {
-	return blk_mq_rq_state(rq) != MQ_RQ_IDLE;
+	return blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT;
 }
 EXPORT_SYMBOL_GPL(blk_mq_request_started);
 
--
