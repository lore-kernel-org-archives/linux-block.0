Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700EFCA1002
	for <linux-block@archiver.kernel.org>; Tue,  5 Sep 2023 16:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350821AbjIEQY7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350428AbjIEFCF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Sep 2023 01:02:05 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40C3CC5
        for <linux-block@vger.kernel.org>; Mon,  4 Sep 2023 22:02:02 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf5c314a57so10158535ad.1
        for <linux-block@vger.kernel.org>; Mon, 04 Sep 2023 22:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693890122; x=1694494922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUzgQhmUcrpYjy4XRQMDJNrGSBxTkLFduYpDV6nXTf4=;
        b=dcYZotGLb/Y407iDJHpSYDCKweMjVvjrwwhOwr9G8nDWsBUyx02jhiZn0JI9/y2T4X
         sGYF5Oyr9m4s5oPbfEMgbA3N7GtADmV1G8rAmynCe92/XqRFcSPcDQWomFAeKyCj+cOA
         SCpgYrvafMa1SVw+hOnK2rQix9a0MQ3sSmMY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693890122; x=1694494922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUzgQhmUcrpYjy4XRQMDJNrGSBxTkLFduYpDV6nXTf4=;
        b=BKs1RI55fRLE1ZjHqe0S5iWVYacL3EWDqMyos6jsfH9lEeHkWP3HTaSCPDq5DVITmw
         VcWslls4NVLPm9bahxXaCF84ZqKvdt03DmEuqrSxL1AY1/YSWUUELBSfAWWjXGk9iCxN
         rMRlT8r8cj4N43vXFvFYTU75b4bRpbRX1pe77nKDOclLJPSnGtAQQ2urP/9vteHIaUgf
         EUGptwV9R9OL1rh86maCBnis4Msf/149SfXM+Zf8iqSQ5QD0j6tuFmXLWcQO/yxprlWf
         rH3GHoJBfoJLgyF5/cMpjZifLI1K+dLmaKxkOxv7+D76rr+TpM3EhEiAzVFSI/mPWreR
         wleQ==
X-Gm-Message-State: AOJu0YyXC9XKWzbjI6uoDNjFfUp7Q1TrG0yNtCsFpS6rChU32LsXw2gb
        /t2xS0UIq3QxlEqQEZ7ChKy08w==
X-Google-Smtp-Source: AGHT+IHg9457MHuGXNN4ZmcVXfXbY1b00sKmCn2j8JB+/PbcADiHRIDBL3G2Fq4BpQboAJ0SD8b4uQ==
X-Received: by 2002:a17:902:c94d:b0:1c3:3c0f:3dee with SMTP id i13-20020a170902c94d00b001c33c0f3deemr4069125pla.31.1693890122119;
        Mon, 04 Sep 2023 22:02:02 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:46d9:d35:d74e:cbe0])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902e98900b001bbbbda70ccsm8313006plb.158.2023.09.04.22.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 22:02:01 -0700 (PDT)
Date:   Tue, 5 Sep 2023 14:01:57 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ze Zuo <zuoze1@huawei.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk,
        akpm@linux-foundation.org, ying.huang@intel.com,
        aneesh.kumar@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH 1/2] zram: add a parameter "node_id" for zram
Message-ID: <20230905050157.GD610023@google.com>
References: <20230901071942.207010-1-zuoze1@huawei.com>
 <20230901071942.207010-2-zuoze1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901071942.207010-2-zuoze1@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/09/01 15:19), Ze Zuo wrote:
> Now, zram memory allocation is random, however in some cases, specifying
> specific nodes for memory allocation for zram may have good effects.

I'm sorry, but that needs benchmarks in order to be justified.

> In addition, when memory tier is supported, demotion can be achieved not
> only through page migration,  it is also possible to apply for memory by
> specifying zram on low-speed device nodes, such as CXL memory devices,
> and compressing pages to these devices through memory reclamation to
> achieve similar effects to migration.

zram->table has nothing to do with zsmalloc pool. zram->table is a
fixed size (it depends on block device size) array that maps block
index to zsmalloc handle. It's allocated once, when the device is
initialized. Compressed pages are not stored there, zsmalloc pool
is a separate thing.

[..]

> +	zram->table = vzalloc_node(array_size(num_pages, sizeof(*zram->table)), node_id);
