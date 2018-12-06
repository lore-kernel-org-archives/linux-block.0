Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FDBC04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 18:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE32208E7
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 18:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Pd2/ClAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE32208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbeLFSIu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:08:50 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55030 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeLFSIt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 13:08:49 -0500
Received: by mail-it1-f195.google.com with SMTP id i145so2811172ita.4
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 10:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4DYf02O2IGkskIAGwahrfA/XfQxqP1VnHNoIlG4ydLg=;
        b=Pd2/ClAD3WN0W/d++wVwcEeG7nDyi7t8itv83FHl+vInAT8Ac90MjOijGVLqI9IbWW
         J4wc2OHjFSpZfHyMHlegXLk9VWn68fU2mtqElwLzvpJwU/q0qum7st0pcXz2rRkSQbEa
         8PMOWwrihMl5IqvvdokMWxILw6zZcrtyxz87EXaO7HPoaAUn/BqLohWTUMvgfR/Sbnfm
         SjRpnP8k3RlEoHDyEX72rCCizCG/lTyyS/KWNo0cx+oYVG2KzrxSaJlSH0nRg/ht1uzd
         sUcXPa1gmgL/3wAb+F1J5PfvTwGmI+X8zzkUc6uOC5+MrVW0yYkBdyJG+FYFPF6ngWC8
         QzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4DYf02O2IGkskIAGwahrfA/XfQxqP1VnHNoIlG4ydLg=;
        b=pR74q5a82nOQ8VchhTk8UoPWATD9X/3BypQK3NgR3NV1rgWC1d5taN8uLK2GnuIvJJ
         o9gHwS2SezGlULMWE69uOrMhTSmfMK4fNUHMiYLeB8f2gmjEyQnxMt378g7gKJveF/v+
         lwSKNLxYtqPNz8I8hB3/L8xVKpab+TEhEuRYuSYBXX9zyalxnbD6Kfa5+BMpgKi7sEvL
         GKnMQ8f+PVX8o29sNy540NaAPCRYl0zwxrE49M9bXQL1sKhXbp7tITwaJGYEsA1nrOpV
         Z2fh9savIetMDa7lSTjTmmvMtCMOPDiVa8RtGCK89qS7XWoYkdKGdgiH9Zsg09/6yaLr
         tejg==
X-Gm-Message-State: AA+aEWbGl9ZYatjlJ09tg4Fpq0pDCeFzX4H9HhNoFL4DKziVQo7ILygE
        7I3l9Ee7m2K/Lxjm+sowdd645w==
X-Google-Smtp-Source: AFSGD/X7RRCuitTc5ddQtI4GhosgK6p9UFG4rqTA4M3T/oAEi9Td/T+QX9rkJfaLc7kOwIjdl7Om/A==
X-Received: by 2002:a24:2c50:: with SMTP id i77mr17821057iti.131.1544119726920;
        Thu, 06 Dec 2018 10:08:46 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id e141sm969544itc.40.2018.12.06.10.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 10:08:46 -0800 (PST)
Subject: Re: for-next branch and blktests/srp
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <1544114872.185366.250.camel@acm.org>
 <41bbac1e-7461-4378-a18d-531b625d6784@kernel.dk>
 <1544116771.185366.261.camel@acm.org>
 <707b709c-547f-b330-bd37-29b8fc427827@kernel.dk>
 <a73ef579-e4e8-f245-b203-1b52eb41af78@kernel.dk>
 <1544119321.185366.277.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <30f797ff-1d75-ba29-f177-81ae9200a606@kernel.dk>
Date:   Thu, 6 Dec 2018 11:08:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544119321.185366.277.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 11:02 AM, Bart Van Assche wrote:
> On Thu, 2018-12-06 at 10:48 -0700, Jens Axboe wrote:
>> which would result in a non-zero exit, which should be expected for this
>> test?
> 
> Hi Jens,
> 
> Test srp/002 simulates network failures while running fio on top of dm-mpath.
> Since queue_if_no_path is enabled in multipath.conf dm-mpath will keep retrying
> the block layer requests it receives if these requests fail due to path removal.
> If fio reports "io_u error" for this test then that means that the test failed.
> I haven't seen fio reporting any I/O errors for this test with any upstream
> kernel that I tested in the past year or so.

Just ran it on current -git, and get the exact same results. Maybe there are
some clues in the log files I sent in the previous email?

-- 
Jens Axboe

