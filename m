Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8B6C07E9D
	for <linux-block@archiver.kernel.org>; Mon, 26 Sep 2022 20:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiIZU6S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Sep 2022 16:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiIZU6R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2022 16:58:17 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AD2A0317
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 13:58:16 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t3so7363586ply.2
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 13:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=DsCt9EnBkB9XONb0mXjIxGr6dtklTnJ0PfTUr4NBJsI=;
        b=oOatuH7ZCBFtR57AbpQECV/YWqkvugbR22uBnQVRwZL5kIcTKlvlxFIs5wjBoYoWrK
         jME05Ef/ypej0+RwVa+ekPAJmFWszVscmmxGjho+o3aA4P/kRTbRKfiZ2qade6HU/pZD
         u3cRFrmfXJ2fIz49u8yNQUjNc3becqZpnKhQHq9yTExuoCX6k5TSWB55/M5iPjZtfhmY
         ussToKOHlmljE7wrB/T4n6/2zmkCvrPZGxx8saFShwTB5fhH4jRGDn4bto5guVreylFr
         a5Ko/+ZkmrdXXcfnqR+uQDof0T02r9AjSf2Vkc6yik9/GS1ATztrnRxpxm5H2UZqEGx2
         bgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DsCt9EnBkB9XONb0mXjIxGr6dtklTnJ0PfTUr4NBJsI=;
        b=1lZVCPX58VUVXsxefyQfyww3h/xDUAN7zWM2EGfy3Ic15WihFJM+D3UqK0PS+mg0pg
         l8NF5JMoJ0qKuC1Bs2qgixWqR+tMsaXK5qLJN7Eu5Z2EHAIM2QV2gkK7ov4XDZ1RkOkO
         q+gfRgA1EIK2WNl9JFEnXsdQD4fvv/ZoRpfdikkt7I9W47fgX9bWLHVfn5ITlkZ22OoD
         Yd/zwfJNAWdwMJoULamqrsKVTRDoTM5MV5YDa1hm7X4PySDpj4k6Z1cqB8VoxD8NphEP
         ADKpNzO5LuDfZFg6bpNTMNYNwq9q5gkVqPbHCuAeux1KFmtwofhklaj8D7aFB47w+RQp
         zPfA==
X-Gm-Message-State: ACrzQf10u4aqZ/E1ji5wROC4MHrKpGyo4Qwvo8rh95JkhiH9Mz+mXDm2
        goCXCmDIIi04fpDVTz9RsqhxUF7OWSjzwg==
X-Google-Smtp-Source: AMsMyM6K6HTjIqM7plhQBrMKWlQVztzQebV5U3un6QUTQUTidvZkmawF+ZkuMSUw+n1YCor6Evidcw==
X-Received: by 2002:a17:902:f612:b0:178:a692:b20a with SMTP id n18-20020a170902f61200b00178a692b20amr24180577plg.55.1664225896363;
        Mon, 26 Sep 2022 13:58:16 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a7e])
        by smtp.gmail.com with ESMTPSA id z25-20020aa79599000000b005361f6a0573sm12652517pfj.44.2022.09.26.13.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:58:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Sep 2022 10:58:14 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 04/17] blk-cgroup: cleanup the blkg_lookup family of
 functions
Message-ID: <YzISZiS2RYWxDSqj@slm.duckdns.org>
References: <20220921180501.1539876-1-hch@lst.de>
 <20220921180501.1539876-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921180501.1539876-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 21, 2022 at 08:04:48PM +0200, Christoph Hellwig wrote:
> Add a fully inlined blkg_lookup as the extra two checks aren't going
> to generated a lot more code vs the call to the slowpath routine, and
> open code the hint update in the two callers that care.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
