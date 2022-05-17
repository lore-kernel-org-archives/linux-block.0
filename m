Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5786FC433F5
	for <linux-block@archiver.kernel.org>; Tue, 17 May 2022 08:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240893AbiEQIBl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 May 2022 04:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242504AbiEQIBW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 May 2022 04:01:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C3A1E3FF;
        Tue, 17 May 2022 01:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ZBAUFPP6MGHK3g6Y74Fe0x7EEYkHIwH7T3bXCHfBli8=; b=xyb2eDwXXbzqOQ5sYHTP6ELaAB
        L8+sXzaThJwcZkwzKh4xOLVSzInFcktAu9xocz/YL7yPI33v0QX/PozOfuTTBw54HDecH3gtqMlo+
        4J7Ulfr7J80TvvsiZlUnRwaoJZwVoXSfn3rSHJXJj5AWbTqCzMasLK+wvnbi7sLY4dJuc4M3bld07
        xh2+UjqeHaF9pQzn3IkdiL/ODPYfnZnKxpai4FY67qia1J7pQeZHgjwedObj74BxYk0g19klosln3
        97CP59jy458nZUCDc10sPlwRgsIustj+dT+QUpny6xs81dYX0P84a8RbURT6/y1q8jxAL9QtaVNqD
        c3xPpJug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqs8m-00CJCR-Ta; Tue, 17 May 2022 08:01:12 +0000
Date:   Tue, 17 May 2022 01:01:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Harris James R <james.r.harris@intel.com>,
        io-uring@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V2 0/1] ubd: add io_uring based userspace block driver
Message-ID: <YoNWSFWNAastFVDP@infradead.org>
References: <20220517055358.3164431-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220517055358.3164431-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Please pіck a new name for this driver, we already have a block driver
called ubd.
