Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5010BC001B0
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 21:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjHHVmW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 17:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjHHVmW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 17:42:22 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1171115
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 14:42:21 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5643140aa5fso859573a12.0
        for <linux-block@vger.kernel.org>; Tue, 08 Aug 2023 14:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691530941; x=1692135741;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m12kzZN53IMQvTnsANViF0li6YYyhC19zBBHQ0jIm7I=;
        b=OkeUWhkbXJYC83xSHTdERH+GDd/onOYGF9X/YhejGcbkv5o8BdT//Lw6k7l0Hn278i
         VfROO2znwsiBA3RKhmOmsH0Fppj7eMhfgfClGVRcz5cUmuyckpiptwFB/HSGdRs6PGpO
         5q2BX2CRpB/O7Jj2tGxBIDF24Fhp36KOnFO/Y/LhzxTnbX0crsewjJOU1BdINwybSJo/
         8TciXuEUs1Z5ypnMkoExT7Sol3z4xbBipbtgoopbj1JaF9EmL/rChRUDcSEkLTCpa4ES
         hUO00yEol78psLo6qYKHRCcndBPxzQt/de/KcGS6cTDnFE5OXIhQ98IJE3Yit0Uo1B1B
         N0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691530941; x=1692135741;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m12kzZN53IMQvTnsANViF0li6YYyhC19zBBHQ0jIm7I=;
        b=kHRPJfXW523ez9DesWzzeRiEe0ObyS7Zd2PRGifKpJU7Qwco0BXz2zkBE1LBAqCx5W
         O7lgTjIJbvomtansuLmYapaf1jMZwJHzW+6QqRmvgj11nxmVBn0YpnitMqjtb7Ge7Kr3
         6kmhaOodKXwYHajkIpr1Fj1J0j953RznMzx8xV9EMlAiZ94aVfO+MLgO1rqzf7ajVMl+
         fQpZrNJ4v/E9pbxV0G/oy5JRda6ReEom9GuOO+mHbJh6UfzWnu33Oc/OeEcd0Xw4sDHN
         prhwYhsVvWA1gn7zUsYjd+diDBeg0G8UbAhxX9giDkTFpe2acpS7Q+OqlX9lq5DSoORF
         UiNA==
X-Gm-Message-State: AOJu0YzXlCtEiJc9Py9AYe539jutEwz0WZQpfXWZj0sJEWlaMyeNSAh9
        EYbN+WqskZF93snShXzUtqUaWw==
X-Google-Smtp-Source: AGHT+IEnl0gcgXkpar0L9ffaoVnAGPr9xosKw6vvVcOstkNGhnJRTyKmFHqPJdmD/cgEk/xlRO5BxQ==
X-Received: by 2002:a17:902:e88f:b0:1bb:d7d4:e2b with SMTP id w15-20020a170902e88f00b001bbd7d40e2bmr1076777plg.0.1691530941128;
        Tue, 08 Aug 2023 14:42:21 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ea8400b001b53953f306sm7338861plb.178.2023.08.08.14.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 14:42:20 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, josef@toxicpanda.com, chengming.zhou@linux.dev
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
In-Reply-To: <20230804070609.31623-1-chengming.zhou@linux.dev>
References: <20230804070609.31623-1-chengming.zhou@linux.dev>
Subject: Re: [PATCH] blk-iocost: fix queue stats accounting
Message-Id: <169153093995.139918.10632912851603759401.b4-ty@kernel.dk>
Date:   Tue, 08 Aug 2023 15:42:19 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 04 Aug 2023 15:06:09 +0800, chengming.zhou@linux.dev wrote:
> The q->stats->accounting is not only used by iocost, but iocost only
> increase this counter, never decrease it. So queue stats accounting
> will always enabled after using iocost once.
> 
> 

Applied, thanks!

[1/1] blk-iocost: fix queue stats accounting
      commit: c992226e984b93b316005ae4b12f2dce1e11630c

Best regards,
-- 
Jens Axboe



