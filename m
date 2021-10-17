Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C85C433EF
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 16:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E972360F48
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 16:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344260AbhJQQme (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Oct 2021 12:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344264AbhJQQmc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Oct 2021 12:42:32 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274FEC061765
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 09:40:23 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id 188so13481695iou.12
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 09:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AA9A+Zlva317NIfypRYc9E4tQrCZT2z4OCSN5FYuo3s=;
        b=6kVA+4A8fvoLxgstDg4L7HTcvrcAPOFtdQVwmBfM3Nr9X6MOyIfztfCEhyPHRMZABq
         psTj+/Tk3Xg27OQXqClky7pFZFYpPeO+NLITe4JXUE0TbY4t/2c0dle02eri6/yraJv8
         Z+iIKvez0817fElA/iFZ1WXPhVMuOx7BYitnjfM0VNsRdDm0cefW9ZeTZ/i3y1HaafYd
         aSIm8HAjoK5nIbvS/adTf0tQZzx6MiXodwe8xsn8YQkRdZFuPQrLv7RIC1/QS9ouU2/w
         ihvHRRiI6z2R9Zi/G+9Yc5/YOgvNSLsjDUIfokXtEmeHghtvphRN2iG18/6OVOxygAd6
         eGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AA9A+Zlva317NIfypRYc9E4tQrCZT2z4OCSN5FYuo3s=;
        b=FO19MdtUDHSsImfd2mZwoL7t9HRzy7oErHLsifk1KIkK4zw825Fm3GmcHhv69oPueP
         rM1TNwYnOtTB/cM2JJlpFyRJ5NAtSvRfwveDWYQx3XrIigh0P8sFrNpBDqKqXXfXM58t
         RGLw0sgaO9Z+Lmp7dRD+HnMEfzhyhVoaKo79wKWHlxpQwsSuNXuDXESZ7XUz4z8EdniX
         F1swghlvmDuXy0PlnHgAcYIkhlOxFCN5jQILlIE/Eh5pwXXBIwwTAozs2rYGbwAA6VU9
         iojCo1O+7OfiuCxEkj6jn7G5lbt2Ey3os4w4kqS75FFa+CFIOXry5KMLsTb8BCnZjXDU
         ie7Q==
X-Gm-Message-State: AOAM532Wz38NP9JPZKXjbB2eUPXnGSV92Q48mbV3Uu5G1QwDy5F6a9Fy
        xAGCOrjHbXZzQ1FoEcPQpBB1Bw==
X-Google-Smtp-Source: ABdhPJyHtcncnPaLkKEApqHE0z1C3dNkwRnln4ejJBuLmOAJvY9NdNBB+r9YLVK97AatIZ+B071qhw==
X-Received: by 2002:a02:6666:: with SMTP id l38mr14990150jaf.146.1634488822456;
        Sun, 17 Oct 2021 09:40:22 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id z26sm5576059ioe.9.2021.10.17.09.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 09:40:21 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH block-5.15] blk-cgroup: blk_cgroup_bio_start() should use irq-safe operations on blkg->iostat_cpu
Date:   Sun, 17 Oct 2021 10:40:18 -0600
Message-Id: <163448881598.109630.15974180935956486992.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <YWi7NrQdVlxD6J9W@slm.duckdns.org>
References: <YWi7NrQdVlxD6J9W@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 14 Oct 2021 13:20:22 -1000, Tejun Heo wrote:
> c3df5fb57fe8 ("cgroup: rstat: fix A-A deadlock on 32bit around
> u64_stats_sync") made u64_stats updates irq-safe to avoid A-A deadlocks.
> Unfortunately, the conversion missed one in blk_cgroup_bio_start(). Fix it.
> 
> 

Applied, thanks!

[1/1] blk-cgroup: blk_cgroup_bio_start() should use irq-safe operations on blkg->iostat_cpu
      commit: 5370b0f49078203acf3c064b634a09707167a864

Best regards,
-- 
Jens Axboe


