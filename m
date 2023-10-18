Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C37CDB474
	for <linux-block@archiver.kernel.org>; Wed, 18 Oct 2023 03:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjJRDRj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Oct 2023 23:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJRDRj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Oct 2023 23:17:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03E3FA
        for <linux-block@vger.kernel.org>; Tue, 17 Oct 2023 20:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697599012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MNOG677PLDM35qlf3oa8HmbCc7NNWIlZZfhXqpVgxTI=;
        b=KAgtP5lBJiLdMR79hebN298xWEEUgjO8JncQt3ScQ1Chb+IDfFLuw8+2BWOFrrRetE7k51
        7FOhQgCqfGI/y5vBeTZI1uf4wqrZ8fYhPWRv3vo+7O3atTaOb6KOTVPw+qjV6w1YVNnYAn
        3hLJR7sf0Qohe6WqMXSljb37sFzrOTo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-sqhNt7EjNA2prCEusHuBeQ-1; Tue, 17 Oct 2023 23:16:39 -0400
X-MC-Unique: sqhNt7EjNA2prCEusHuBeQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95B2C882387;
        Wed, 18 Oct 2023 03:16:38 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 60B3B1121318;
        Wed, 18 Oct 2023 03:16:33 +0000 (UTC)
Date:   Wed, 18 Oct 2023 11:16:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] block: move bdev_mark_dead out of
 disk_check_media_change
Message-ID: <ZS9ODABLaRVcI5iy@fedora>
References: <20231017184823.1383356-1-hch@lst.de>
 <20231017184823.1383356-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017184823.1383356-4-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 17, 2023 at 08:48:21PM +0200, Christoph Hellwig wrote:
> disk_check_media_change is mostly called from ->open where it makes
> little sense to mark the file system on the device as dead, as we
> are just opening it.  So instead of calling bdev_mark_dead from
> disk_check_media_change move it into the few callers that are not
> in an open instance.  This avoid calling into bdev_mark_dead and
> thus taking s_umount with open_mutex held.

->open() is called when opening bdev every times, and there can be
existed openers, so not sure if it makes little sense here.


Thanks,
Ming

