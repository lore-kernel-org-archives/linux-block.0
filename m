Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9212BC04EB8
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 15:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6008520672
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 15:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6008520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeLJPLy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:11:54 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37844 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeLJPLy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 10:11:54 -0500
Received: by mail-qk1-f194.google.com with SMTP id 131so6641563qkd.4
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 07:11:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EZEXqVsGlcWwd+zxCX0Sx+FyYEo0QQyyCphOF1axsUM=;
        b=oT+uaqULXQs/ZfodZoQCBxoaHYN2aWAs44NjkxiniK8kvInp6fq0JKXWHl34JP0vAF
         GzbDHpIFLGTdJb0UHvNb6M6Cpgi8w328x/bTUm4rwzs4qUruogCmdgz0Uz4FyKDm8RxQ
         Me9PTmQl6bWovwce41HnP3wa5iMc1t4FuuoTJP/XDWzZ6sgRfSWFruyumXlsvl04kGsw
         cvMy+4TrH3+UuYEeDvTtuIperQ527PxItqHGEZ8AhmpzdI1+Zwy9vKa++jx7/EfcWEN+
         EZeqiHWaP6CCdKdq+pwjFMtka/9v4gXt8IG7iDY4cQKRrYAZ+jSPx219ollVpgX8AW9G
         fpCQ==
X-Gm-Message-State: AA+aEWasQuUAVEErU3lXnhS+pAkJZKzkMGFzJ4WFCH9rddTuJhTXFbY3
        7mSls85Id0sDHRKlAwa6tYOZkKl1Ezg=
X-Google-Smtp-Source: AFSGD/WHiYHLzjbxErlxVHpXTG9zIZJMtMNWvhpF/aOk+de5i1iTqzMUoE+6xH+HpcOx7hVYXSuV+w==
X-Received: by 2002:a37:18e5:: with SMTP id 98mr11498917qky.333.1544454713424;
        Mon, 10 Dec 2018 07:11:53 -0800 (PST)
Received: from loberhel74 (035-134-022-126.static.chtrptr.net. [35.134.22.126])
        by smtp.gmail.com with ESMTPSA id z8sm8505476qth.34.2018.12.10.07.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 07:11:52 -0800 (PST)
Message-ID: <1544454711.18488.1.camel@redhat.com>
Subject: Re: [PATCH] block: Restore tape support
From:   Laurence Oberman <loberman@redhat.com>
To:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Todd Aiken <taiken@mvtech.ca>,
        Keith Busch <keith.busch@intel.com>, stable@vger.kernel.org
Date:   Mon, 10 Dec 2018 10:11:51 -0500
In-Reply-To: <20181210111729.GA21553@lst.de>
References: <20181210030814.13235-1-bvanassche@acm.org>
         <20181210111729.GA21553@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2018-12-10 at 12:17 +0100, Christoph Hellwig wrote:
> On Sun, Dec 09, 2018 at 07:08:14PM -0800, Bart Van Assche wrote:
> > According to what I found in
> > https://bugzilla.kernel.org/show_bug.cgi?id=201935 patch "block:
> > Clear
> > kernel memory before copying to user" broke tape access. Hence
> > revert
> > that patch.
> 
> This looks wrong.  The patch from Keith is obviously correct for
> normal usage of bio_copy_user_iov.  The SCSI tape drivers use the
> somewhat odd null_mapped case, so we probably need to refine the
> checks
> for that a bit.

I am going to look into that, just connected a tape device so I can
reproduce and then see what we need to make it more specific in the st
driver.
I may need help from folks who understand the bio stuff better than I
do.

Back when I have more.

Regards
Laurence
