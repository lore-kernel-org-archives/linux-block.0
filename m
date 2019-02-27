Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0A4C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 13:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8D52133D
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 13:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="2NIQEUZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbfB0NZd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:25:33 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38806 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfB0NZd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 08:25:33 -0500
Received: by mail-pf1-f194.google.com with SMTP id n125so8026100pfn.5
        for <linux-block@vger.kernel.org>; Wed, 27 Feb 2019 05:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P1F25RJCzJgtPj8lMxuO8h150lg2Ucqwwd8JGMXQ2wY=;
        b=2NIQEUZAGN3Tch9bBL2HFCL6js+OzyW6oCP3TdkmTCNWZQp6SN9nmnAxazzzqK/AC8
         XP+Ub3YFVx7JBe1G5Ba8ZLO+cV4fisF2FzENMh+UpNpwPr2/FB+fx5kK2fe3vhjd3ets
         XsBH7bUtrJr9Eu/DApv/egH49tneyICvgP3Lqfpv+qCeGwFrDihgGxVZ32HlYDHEYmDX
         n/zXdr9V+h1ziGx9FgvaBDSENK3X7JtLaIOk9k097zYKwCE15+aEZWmfd8fQFXoqrDcb
         6pOWMnJiJGNYp2s6Dnd2UnguElSUqlOaCY8uZYG6qIA/5VzXOVGQAlTX+Ju8QUXiML2V
         Scew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P1F25RJCzJgtPj8lMxuO8h150lg2Ucqwwd8JGMXQ2wY=;
        b=FJKpbFEflpasZb6IDlM9cWGTGGF7TLFvajeQ8KpY+MAOQ5hfdVua/6YaNnyuJaxQvL
         whtpPCXClxmIv1Lniler4jTY9jFQU1hLDm0SN+iei2EqF/OZHRggtzOQKp6+TLr5XsuH
         yLwHJ91z8efNF5cbbApWTfbMKXwZggAwOhkTaR1vQHKlxZnsa8TYGb4aW8B30bfrYz4J
         wHHDsZzyqaPEBTO796Vn9Y0i8t4j94w6lW8c1T/1tDZhu6+9Q1nFL7uAPKhsOz/74d6f
         YU9LAJEQAQUYMdMhukPzXck+1qf5Vdhr5mtbd03jqpInbIl2KYMCIo1EPpMJlNKBTX78
         6WeA==
X-Gm-Message-State: AHQUAuYxAp61+ZTcuYVpAUXB6O0N8xKFsRqIctxGFAjzP/l5BwwOJ377
        3Ct2oOMOIDjbZvwyAvBjskYP6btpZuj1Cw==
X-Google-Smtp-Source: AHgI3IZZ16mmatlXzkXU8oMZ2w8xTbGwyyOhIxI7sV2VkMIP9WMyfq/tZafuUuEpemH2up4fpix9JQ==
X-Received: by 2002:a63:e447:: with SMTP id i7mr2971102pgk.70.1551273932621;
        Wed, 27 Feb 2019 05:25:32 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id g67sm43540850pfg.13.2019.02.27.05.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 05:25:31 -0800 (PST)
Subject: Re: [PATCH 0/4] block: optimize for single-page bvec workloads
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20190227124013.4828-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <922211dc-2a0d-d030-b072-7bd3e7f6fdcf@kernel.dk>
Date:   Wed, 27 Feb 2019 06:25:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227124013.4828-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/27/19 5:40 AM, Ming Lei wrote:
> Hi,
> 
> The 1st patch introduce bvec_nth_page(), so that nth_page() can
> be avoided if the bvec is single-page.
> 
> The 2nd and 3rd patch adds fast path for single-page bvec case.
> 
> The last patch introduces a light-weight helper for iterating over
> pages, which may improve __bio_iov_bvec_add_pages(). This patch
> is for io_uring.

This reclaims another 2%, we're now at 1585K for the test case.
Definite improvement!

-- 
Jens Axboe

