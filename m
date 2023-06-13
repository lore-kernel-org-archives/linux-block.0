Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADBDEB64D7
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 13:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbjFMNtg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jun 2023 09:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242472AbjFMNtg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 09:49:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76F810DA;
        Tue, 13 Jun 2023 06:49:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5FC5568AFE; Tue, 13 Jun 2023 15:49:32 +0200 (CEST)
Date:   Tue, 13 Jun 2023 15:49:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianjia.zhang@linux.alibaba.com,
        xiang@kernel.org, casey@schaufler-ca.com
Subject: Re: [PATCH v3 2/2] block: fine-granular CAP_SYS_ADMIN for
 Persistent Reservation
Message-ID: <20230613134932.GB23303@lst.de>
References: <20230613084008.93795-1-jefflexu@linux.alibaba.com> <20230613084008.93795-3-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613084008.93795-3-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
