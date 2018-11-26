Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9406C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E08B20664
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YS22Ja36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E08B20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeK0DVy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:21:54 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:39223 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeK0DVy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:21:54 -0500
Received: by mail-it1-f181.google.com with SMTP id m15so28629606itl.4
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=7Q3SsSEiydM+sGOhyNMTLDXCfrqcR1dO9d1ZpQFh/hw=;
        b=YS22Ja36MfFlmckhLnBoqnqXPMwnnToO/j5IAECh19p6bHxV3KznFcuZWEt5QBpn7l
         rIj18si2xLtfk3QGNah8zykplHqKbQMP2Iyh7ZOGyoRRlU9RFhiNMq2dzSO20F4mLSHm
         iy+MGDBtOutjnn6R+/lACvNRwf+1QwPvwGNns+4jCI8ZPwTOrZzS6OhciNYJpcgHDqK7
         r5NLdFt4sbsU7tNSyyvb8TWvb5f+o7g8Zoof09nvlfobCa4jlI1uCSa+GB6MQowvLScL
         FJ8Ye07o2Q6McTdUb1/X77yESP474avqXnSzWCtVm+opqZB+1RBn8JS7GM3HmJeNSREU
         oZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=7Q3SsSEiydM+sGOhyNMTLDXCfrqcR1dO9d1ZpQFh/hw=;
        b=Cp+de56vpvBxnuJaOMndyyx2FP48tJxTqGoem9sGHkEXwEkBJetQgFrU8F5xNdCWsJ
         v3kZy7+kg17iPMPLhUf4adlIa6GpkyhcI17TasmQE4vG9FqYOaEBoMZaWUkOVYLGU0qV
         kRZnwXilme/j+1Z1ThaUovqEUN09HhCHo+XhnL90OaA8CdfUIQC6xtYQa2I7TItx9+gq
         UkyhB/J5jPc0+badZ+pN7SRprFuUkxlNZeN4meKG+5PObPAs0TmNFVvXtNBEf/aRovbN
         vZESV6DecvgRDnSAZvBL4sBPpiQzywujbu3XkcBl40b4b067nceqh1ns2wW7LVVUpORs
         Fo4g==
X-Gm-Message-State: AGRZ1gJBCsLA4KRx9bdJVCFiUet3KW0n+IXCJGULEYTggFiMN2TB3ujl
        g5ny7IPVciF6aYxZ2PFKhmjtVdShvkA=
X-Google-Smtp-Source: AJdET5ccKRK3doE8xiuuMVHoDrWSTsPj8lJdVoTVWi7qScb5uJd2S+agrMQZvh91kKb2ZrGZzLI7lg==
X-Received: by 2002:a24:2fc1:: with SMTP id j184-v6mr25038979itj.28.1543249638313;
        Mon, 26 Nov 2018 08:27:18 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id d3sm505059itc.40.2018.11.26.08.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:27:17 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Omar Sandoval <osandov@osandov.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: sbitmap: don't use READ_ONCE() if we don't have to
Message-ID: <9c657cca-97e6-68e4-6dbb-ac85a6e6511d@kernel.dk>
Date:   Mon, 26 Nov 2018 09:27:16 -0700
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

We don't need to use READ_ONCE() to read the map depth and word
fields. This reduces overhead of __sbitmap_queue_get() dramatically
on high IOPS devices, taking it from ~3% to a tenth of that.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 lib/sbitmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index fdd1b8aa8ac6..77442e04aeac 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -243,8 +243,8 @@ void sbitmap_bitmap_show(struct sbitmap *sb, struct seq_file *m)
 	int i;
 
 	for (i = 0; i < sb->map_nr; i++) {
-		unsigned long word = READ_ONCE(sb->map[i].word);
-		unsigned int word_bits = READ_ONCE(sb->map[i].depth);
+		unsigned long word = sb->map[i].word;
+		unsigned int word_bits = sb->map[i].depth;
 
 		while (word_bits > 0) {
 			unsigned int bits = min(8 - byte_bits, word_bits);
@@ -375,7 +375,7 @@ int __sbitmap_queue_get(struct sbitmap_queue *sbq)
 	int nr;
 
 	hint = this_cpu_read(*sbq->alloc_hint);
-	depth = READ_ONCE(sbq->sb.depth);
+	depth = sbq->sb.depth;
 	if (unlikely(hint >= depth)) {
 		hint = depth ? prandom_u32() % depth : 0;
 		this_cpu_write(*sbq->alloc_hint, hint);
@@ -406,7 +406,7 @@ int __sbitmap_queue_get_shallow(struct sbitmap_queue *sbq,
 	WARN_ON_ONCE(shallow_depth < sbq->min_shallow_depth);
 
 	hint = this_cpu_read(*sbq->alloc_hint);
-	depth = READ_ONCE(sbq->sb.depth);
+	depth = sbq->sb.depth;
 	if (unlikely(hint >= depth)) {
 		hint = depth ? prandom_u32() % depth : 0;
 		this_cpu_write(*sbq->alloc_hint, hint);
-- 
2.17.1

-- 
Jens Axboe

