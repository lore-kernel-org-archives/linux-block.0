Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8142BC433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 07:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiGUHfc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 03:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiGUHf0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 03:35:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78CCF18382
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 00:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658388924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lUOVoKY1fywme4juDdhU1xFrS8NmKPQfGLh7OjvnFKU=;
        b=YQkRyaXOIufQP74V8TlNqD+sOVWgIYA5bA2W9Euat91qc/BqvSTMHzYU3jQqVjMpt1HONG
        /nUWiMWfbSARg4+TWfORb62fSL1BKGH/HrYAarjiG6z4e+ZNiSePBWwdqN9bvhtCLKZ2/o
        GRm7OBCbgxPF13X5fmTMWw7DW8EZWo0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-W1aNQzIXMx-wUiRgqWEd8A-1; Thu, 21 Jul 2022 03:35:20 -0400
X-MC-Unique: W1aNQzIXMx-wUiRgqWEd8A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FCF88037AC;
        Thu, 21 Jul 2022 07:35:20 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B0E3CC2811A;
        Thu, 21 Jul 2022 07:35:17 +0000 (UTC)
Date:   Thu, 21 Jul 2022 15:35:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 6/8] ublk: fold __ublk_create_dev into ublk_ctrl_add_dev
Message-ID: <YtkBsDqRH0LUoEyI@T590>
References: <20220721051632.1676890-1-hch@lst.de>
 <20220721051632.1676890-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721051632.1676890-7-hch@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 21, 2022 at 07:16:30AM +0200, Christoph Hellwig wrote:
> Fold __ublk_create_dev into its only caller to avoid the packing and
> unpacking of the return value into an ERR_PTR.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

