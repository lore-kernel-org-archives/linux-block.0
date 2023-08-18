Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E99BC3DA66
	for <linux-block@archiver.kernel.org>; Fri, 18 Aug 2023 01:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356834AbjHRBQ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Aug 2023 21:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356872AbjHRBQo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2023 21:16:44 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5648F3A89
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 18:16:43 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1c134602a55so56108fac.1
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 18:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692321402; x=1692926202;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qHPxgI+MW4SaOUNUrKbhHywGedPFGu2hUBebAKEvLc=;
        b=Dj31joKXbt4pIMemqTw1L6yMWVlyw5kJ1zjfi+8m0nU3x1JzGMUV0dpm1iScXFZOnm
         xtrqNQWR+vBBoOGcS4VVv79uLRNL6zZE2L62V0FhKmq5mXP8JACKxf1aaVzty188zxgt
         oZnbtiu1diRM63gOJbWTo6nveeTWEfPzDrpY2H6+lquAfhUt3BnT8wDmvSEx3jhgd/Yc
         +x0hiKqoopQePpwyfCcCPVTLQjyzoJfiagE2E+aGdTLD/Ck55ch4FTZaA26ZCSiHQstd
         wq3wGCWLmPcrekSe1yxDNa0TVwa4F/kRZl3hsh2dMH+6u+W0kWjHorHdXIKO/xx+sDNH
         yTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692321402; x=1692926202;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qHPxgI+MW4SaOUNUrKbhHywGedPFGu2hUBebAKEvLc=;
        b=W6MFDa7cSsOgTNbbmUyqQB+kqTss4YdISwvrm/8cKTXepQLLki2/lXPrR5fx0iM6sE
         zs4SfTqtSX7sDNEoFx/F/muGA0rof/LmAax8DCHtlHHP+JvGGESfXRqJxllKFnL9LvpN
         BTDQrwIDKi5uo4oP2PjUpFbqPlaVDEC0cJrwbBCbQ18flnZpYgqQ9csPNf+QTZvbDPy2
         jmWK13fdZO76854iDrmlzU7JMexrvPcyp86/BFmqo3CrJN3DWlHTe7KhhrP7DgZFDkLx
         OVOBa9d5J6rGXvBPtLZ3VFmpla2l3XFeIAF/ajPDwVG0CdxV8yDi5xdnaTzntfpJ47Ko
         fWTQ==
X-Gm-Message-State: AOJu0Yx+oDs7iydx821vwqxTqyFM+c6bSdXODIIyCvxfVX2GsiUWG33x
        bbUKiejAnLI1oOgvkYGkHAcanAcLZedKpZRaaH8=
X-Google-Smtp-Source: AGHT+IGuQbIzqUKgur1Wt/u7IQM5xQre/xKJrvSZ5gNGrgxBcTyVLf/xT/KBwAoOssW5bCPVWALT9g==
X-Received: by 2002:a05:6870:c151:b0:1bf:9fa2:bfa3 with SMTP id g17-20020a056870c15100b001bf9fa2bfa3mr1297716oad.1.1692321402092;
        Thu, 17 Aug 2023 18:16:42 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id gk10-20020a17090b118a00b00263f5ac814esm2138019pjb.38.2023.08.17.18.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 18:16:41 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        xiaoli feng <xifeng@redhat.com>, Chunyu Hu <chuhu@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, Tejun Heo <tj@kernel.org>
In-Reply-To: <20230817141751.1128970-1-ming.lei@redhat.com>
References: <20230817141751.1128970-1-ming.lei@redhat.com>
Subject: Re: [PATCH] blk-cgroup: hold queue_lock when removing blkg->q_node
Message-Id: <169232140069.701299.12329118562683488055.b4-ty@kernel.dk>
Date:   Thu, 17 Aug 2023 19:16:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 17 Aug 2023 22:17:51 +0800, Ming Lei wrote:
> When blkg is removed from q->blkg_list from blkg_free_workfn(), queue_lock
> has to be held, otherwise, all kinds of bugs(list corruption, hard lockup,
> ..) can be triggered from blkg_destroy_all().
> 
> 

Applied, thanks!

[1/1] blk-cgroup: hold queue_lock when removing blkg->q_node
      commit: 94254d59c0d22ecf9fdd1a18dd03652fc6be19e5

Best regards,
-- 
Jens Axboe



