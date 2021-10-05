Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41270C433EF
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 15:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 275E061506
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 15:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhJEPeS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Oct 2021 11:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhJEPeS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Oct 2021 11:34:18 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D86C061749
        for <linux-block@vger.kernel.org>; Tue,  5 Oct 2021 08:32:27 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id i13so22267627ilm.4
        for <linux-block@vger.kernel.org>; Tue, 05 Oct 2021 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=IBEdg256g7XrTRf/DgSzh1YjxdhVgqzhTZgsp9rQe3k=;
        b=Od0MTpLgXXOlBNlUkkeMYhSwI6xqlCTHNJv1W6vZhEThi4qFBx5I00fWx/9l4v6CNp
         1bJSg7uiXpUGvss51BZ4dGA9Hh6NGV414rk6A7z/eGovCKwRe2Qe9Qgy2szPvyFueoui
         klPIzkfnRQHbk6KfWvZifeYu8WfbcVUMj3PymGOngTellnwAVNjxTn9kAFJXjKhLY0zJ
         mcq9lGfpcYuBfqNsLLB7XKj7B9ekx3EGmraW91Pm9QSD5k6l7fMwrJoeJZSKwUWw1Xvn
         TCXNA/VJZSck7b66NxALrfiVvcyuxtLuMmJeUHRsPLlAsxp0mWa6iexLkVdLC9RWc+TU
         v7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=IBEdg256g7XrTRf/DgSzh1YjxdhVgqzhTZgsp9rQe3k=;
        b=DUN2qbdD+SlMhcaBtxUXOPy4tZ3x+NCe5NPWzGNPiTCYmp30vannHVaA0jzhi4717N
         lmeRObH/fTmORh4HluBiD6kwujW0AdU53xwvJXdmuBaQp+yV4MN9r30KiGrTkDjiip/D
         gUZkLZwHk6pqsmU6hWG1hoMahdc1A9M3cCYdeogURpNHYUh+EPq10f+NPbTiZ/Nu7/E7
         G25GXhltvaIQ9LpRUu14ZmMWNSwwrlWjY5NCnoGfQBequchOEiY4HVyHXU1nUUpxWyAV
         jWnrfwd8wBeA23iJHOydB5RfyatziUD96cKh/AIlbuPu1KAz8W6w6nbx2J68D3veUZPt
         rETQ==
X-Gm-Message-State: AOAM5327hZ7OFTx3xT3jvC+cJsNBJiZ1p930rih3J9H5TCm9IGVxCIc2
        5i2rr8nSw3vPi2ANNAzSepcrLtn3tUFfcpRKEdw=
X-Google-Smtp-Source: ABdhPJyVy3ReqQT+6HPJsBMezwYz1ukG/IWuHpN0z6sViKrVb5/TzDYZY/cbUAmDvZPknHLhZbeM8A==
X-Received: by 2002:a92:1a08:: with SMTP id a8mr3532730ila.301.1633447947159;
        Tue, 05 Oct 2021 08:32:27 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y124sm11233763iof.8.2021.10.05.08.32.26
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 08:32:26 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: don't call should_fail_request() for
 !CONFIG_FAIL_MAKE_REQUEST
Message-ID: <50093280-104b-545a-c4c9-2fc3efd45520@kernel.dk>
Date:   Tue, 5 Oct 2021 09:32:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Unnecessary function call, if we don't have that specific configuration
option enabled.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-core.c b/block/blk-core.c
index 5454db2fa263..a267f11f55cb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -697,8 +697,10 @@ static inline bool bio_check_ro(struct bio *bio)
 
 static noinline int should_fail_bio(struct bio *bio)
 {
+#ifdef CONFIG_FAIL_MAKE_REQUEST
 	if (should_fail_request(bdev_whole(bio->bi_bdev), bio->bi_iter.bi_size))
 		return -EIO;
+#endif
 	return 0;
 }
 ALLOW_ERROR_INJECTION(should_fail_bio, ERRNO);

-- 
Jens Axboe

