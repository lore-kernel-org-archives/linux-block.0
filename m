Return-Path: <SRS0=uopx=OM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F99C04EB9
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 21:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978CB20850
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 21:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lxVhJ7/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978CB20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbeLCV4V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:56:21 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:34651 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbeLCV4V (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 16:56:21 -0500
Received: by mail-io1-f41.google.com with SMTP id r9so4440906ioa.1
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 13:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=b80Vd8FkCwLKcUnA02GWgUE14LNoCb7bPqkj5fjAUCI=;
        b=lxVhJ7/XZSPzdS000kvFHvj5sK29qgAKMZKJ6U8clVPqZXGHw7BJPnjbyfhJNMM484
         FEW9UudkRItrzO8T/kGdSSWF4A4Wt4PGiFntR3a/roDPy0zgsyadv+/9c8qYoRLQryY3
         xs0i5icJJMTkNuVfyV3Nqd2s+i2pm80ukt7STYz7Xx5+TU7kkWQfGnLPUOwEAHfthISj
         BY6Syd+jz8SyyH02JeZs0sn4TrDjlDtZctqtyZl+DPEMuC4aN+KM1X4JjVtAzcsVAbaS
         GsjahmmUfB+4K58NeVtbAYJHqEA0uoumuNdOT6zm3HJen/vzdd/UnDxfz9qOciPtcFom
         3yoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=b80Vd8FkCwLKcUnA02GWgUE14LNoCb7bPqkj5fjAUCI=;
        b=lnTiGdyB4/dFZPxvXx3IBIqHFECxXlVzc9fWQwjm8XtZviIAaidnM6zssBeGkshWgW
         Gfb4vc9PHHJvyMG4mxis5sNxTpEr3ADWOnLZ7rbzJsUzowBd8N8T7db6cY1iGqWBWsG0
         wV+SJAb/gFxUob9Ge41ntUD1GsaHvdWm/wPHxAvg+bIFlcv/ivBi3wZG+sODFk0Kkz2H
         kCjbUD7GiY7zr8xozh6A/ZguYEENqpcPdW1eCxUa+mtQj3I7YI+IXFcmoVbQwlAyo2mX
         rBNQh/eHwFWzg1HIdFB2n33j4/OHieMyKpoT+D2J1pzcRVzVKU809YwDR/A5zsejHcfq
         zogw==
X-Gm-Message-State: AA+aEWajYcoWOn4YUFIOJ6hFPNuWQzVBAX3KiI5o6IHEwaDlafoCs9fY
        rAWsWsAfMinALEdjgIayYdkGZvWk2tw=
X-Google-Smtp-Source: AFSGD/WlFskyTKnoXX3hlWJcA8ddAwt0yxsNHnFxchsARhJrkRSB7XSwkLG8UFEZOeoY55FB5zjyPA==
X-Received: by 2002:a6b:6604:: with SMTP id a4mr15226257ioc.10.1543874180776;
        Mon, 03 Dec 2018 13:56:20 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1131::106f? ([2620:10d:c090:180::1:94b1])
        by smtp.gmail.com with ESMTPSA id z23sm6350902iob.19.2018.12.03.13.56.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 13:56:19 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Omar Sandoval <osandov@osandov.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: sbitmap: check cleared bits when iterating busy bits
Message-ID: <8bde3953-56d8-32cb-2c34-582d632f4a3f@kernel.dk>
Date:   Mon, 3 Dec 2018 14:56:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When we are iterating the set bits in a word, we also need to factor in
the cleared bits. Don't call fn() unless the bit is also not set in
the cleared word.

Fixes: ea86ea2cdced ("sbitmap: ammortize cost of clearing bits")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 92806a2dbab7..9f374fbcdba6 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -283,6 +283,11 @@ static inline void __sbitmap_for_each_set(struct sbitmap *sb,
 			nr = find_next_bit(&word->word, depth, nr);
 			if (nr >= depth)
 				break;
+			/* if set in cleared, it's actually free */
+			if (test_bit(nr, &word->cleared)) {
+				nr++;
+				continue;
+			}
 			if (!fn(sb, (index << sb->shift) + nr, data))
 				return;
 
-- 
Jens Axboe

