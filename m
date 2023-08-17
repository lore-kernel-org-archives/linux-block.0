Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5FEC3DA50
	for <linux-block@archiver.kernel.org>; Thu, 17 Aug 2023 16:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbjHQQmW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Aug 2023 12:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353792AbjHQQmT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2023 12:42:19 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD1EE2
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 09:42:18 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6887918ed20so2335756b3a.2
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 09:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692290538; x=1692895338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rnl+DkfnyTGwEkXjajrDtB2k99vpyoIfVdloGCBXA8=;
        b=PObTuIGUzsHBVBFzNAJ1uQkawaMS2DvIYaos+4hu2+EPxvd7eR+X5GMGA/gpNT12MJ
         v1kESEfUIN0sZqeLhUk2LdOaPRVX6i9s4MGy5ku4WcyetsVQtbO7VIvBUTQcXB7GTzi/
         W+E3ynqqdWAo0rCm7sspwx1HT+UHBCMaApUEP+79xdrLCyvGd2bfnM6ZqXLLjbLLmedW
         RoROiy+SNdvQ4omYbQRha/IRnzks2Ut905x4NsrOkkRR2dK4MYeLrBP7wLTdO/qIJUP+
         BJnBwGAQG/ji//ATuMQWfTC7oe5G/7MF+0QDhLry0QEf2RZ+izac907MP/JNYHJVDZbL
         QleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692290538; x=1692895338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rnl+DkfnyTGwEkXjajrDtB2k99vpyoIfVdloGCBXA8=;
        b=XTSurYnu4WIZgjUyv3a2glBT0lq1UvtOsEkVBAeCjZgzv8NUo93iXJaIZcEPl9/nIY
         m21O+jVjXooHMNCI1janNpJDKJ2zme3g9Q/rYTA47EbqkxyFy8B3oqDFW1MvkfU1vBQw
         TITtBbwaw5yIcpXjniysgL1wUA1ve0IDWN+TsXUke1AWI7vSIpA8sYxUDRbtWEfDoAhp
         ARyVbhG65TZvCT7LR/b78EINA11MTg9BL+0yF9VUi2jcAEDvPDf/6xCsai0xV+iG3V0r
         bJkphWLMsiFPMa2wbqBHQDKcaUkDErIwVvQ+dqVlq64XhHcgE4g7gAF+7xfByv1xo3lE
         Qcqw==
X-Gm-Message-State: AOJu0YyorvAEM0TTweZ+q1yhQqfTxssXEw4VOSEbVXqnw3uyippu5ASW
        9mTcznAr5xAVLuO6lZq8RM4=
X-Google-Smtp-Source: AGHT+IH5VTNGq+DguEhLJQI6e+Tjvt8iBJGu+6a1mr1T8rS542z7sWTaE05+hzR3zgqD8V3Y38nruw==
X-Received: by 2002:a05:6a00:1a87:b0:682:537f:2cb8 with SMTP id e7-20020a056a001a8700b00682537f2cb8mr46520pfv.26.1692290537781;
        Thu, 17 Aug 2023 09:42:17 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:93bd])
        by smtp.gmail.com with ESMTPSA id k4-20020aa792c4000000b0065438394fa4sm13428283pfa.90.2023.08.17.09.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 09:42:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 17 Aug 2023 06:42:15 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>, xiaoli feng <xifeng@redhat.com>,
        Chunyu Hu <chuhu@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH] blk-cgroup: hold queue_lock when removing blkg->q_node
Message-ID: <ZN5N5zrBIy-1NLVW@slm.duckdns.org>
References: <20230817141751.1128970-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817141751.1128970-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 17, 2023 at 10:17:51PM +0800, Ming Lei wrote:
> When blkg is removed from q->blkg_list from blkg_free_workfn(), queue_lock
> has to be held, otherwise, all kinds of bugs(list corruption, hard lockup,
> ..) can be triggered from blkg_destroy_all().
> 
> Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
> Cc: Yu Kuai <yukuai3@huawei.com>
> Cc: xiaoli feng <xifeng@redhat.com>
> Cc: Chunyu Hu <chuhu@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
