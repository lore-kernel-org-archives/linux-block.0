Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB23BCDB483
	for <linux-block@archiver.kernel.org>; Wed, 18 Oct 2023 09:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjJRJyc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Oct 2023 05:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJRJyb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Oct 2023 05:54:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB2ABA
        for <linux-block@vger.kernel.org>; Wed, 18 Oct 2023 02:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697622823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q/9KDbwRJFqBl0mAH+HE56sreJMIIRxOC1082s49hO8=;
        b=KEqIKy9KaFtuczi+foS3NKfxlJ66dU/70xEita0RN9RjPjIpcv5Sbs8f5JVfpsz2ax8TGU
        mIncAxv1dwOPIDGnlg29tS0N2C4H+HHY76BqtVhae6o9fg0mZ5BCpZR4j1sVsdD/b0n4nK
        hNGjWPQ+HJC+KVRSXAQ6UqUF6h3g0d4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-BEyT9dudPFW-u9DdyhfEMw-1; Wed, 18 Oct 2023 05:53:34 -0400
X-MC-Unique: BEyT9dudPFW-u9DdyhfEMw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D38C23C1CC3B;
        Wed, 18 Oct 2023 09:53:33 +0000 (UTC)
Received: from fedora (unknown [10.72.120.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 041472166B28;
        Wed, 18 Oct 2023 09:53:28 +0000 (UTC)
Date:   Wed, 18 Oct 2023 17:53:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/5] fs: assert that open_mutex isn't held over holder ops
Message-ID: <ZS+rFPhDoS5yuvS2@fedora>
References: <20231017184823.1383356-1-hch@lst.de>
 <20231017184823.1383356-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017184823.1383356-6-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 17, 2023 at 08:48:23PM +0200, Christoph Hellwig wrote:
> From: Christian Brauner <brauner@kernel.org>
> 
> With recent block level changes we should never be in a situation where
> we hold disk->open_mutex when calling into these helpers. So assert that
> in the code.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

thanks,
Ming

