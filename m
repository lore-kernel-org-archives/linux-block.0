Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D25C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 19:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4152820855
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 19:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="OYRTNxqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4152820855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeK0G0i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:26:38 -0500
Received: from imap.thunk.org ([74.207.234.97]:57560 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbeK0G0i (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 01:26:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Yny2ek0WMIfhvU5K7rmU3S8Ldk9GOfPFZu/HM6flsWI=; b=OYRTNxqMiHhw8yTVkumQWjJ+9+
        FJWVPIhoDXoOGp4H9Oy/pqCZuUXbCFwNIHTH+qKdPGDagZIPmhb01Qd6kS99CIyazTjuPk4EKdqZ0
        v1FZOZv0FG+tBpsWKJoCO3RoGqsG3uKNEGYealmMAOy5PKh9SCjwU5EoeIALwBgdXnsE=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gRMbR-0004vd-Va; Mon, 26 Nov 2018 19:31:30 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 48EC57A442C; Mon, 26 Nov 2018 14:31:29 -0500 (EST)
Date:   Mon, 26 Nov 2018 14:31:29 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] Add use of logger so that syslog files show
 when each test starts
Message-ID: <20181126193129.GB31885@thunk.org>
References: <20181029161557.7652-1-tytso@mit.edu>
 <20181123010221.GA6311@thunk.org>
 <20181126175057.GA30411@vader>
 <20181126183211.GA31885@thunk.org>
 <20181126183723.GB30411@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126183723.GB30411@vader>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 10:37:23AM -0800, Omar Sandoval wrote:
> 
> Hm, what if we output it as KERN_INFO?
> 
> diff --git a/check b/check
> index f6c3537..9b4765f 100755
> --- a/check
> +++ b/check
> @@ -314,7 +314,7 @@ _call_test() {
>  
>  	if [[ -w /dev/kmsg ]]; then
>  		local dmesg_marker="run blktests $TEST_NAME at ${TEST_RUN["date"]}"
> -		echo "$dmesg_marker" >> /dev/kmsg
> +		echo "<6>$dmesg_marker" >> /dev/kmsg
>  	else
>  		local dmesg_marker=""
>  		CHECK_DMESG=0

Still not working, alas.   I tested it via:

root@xfstests-ltm:~# echo "<6>testing 123" >> /dev/kmsg 

It still didn't appear in /var/log/kern.log

				- Ted
