Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7015C433EF
	for <linux-block@archiver.kernel.org>; Sun,  6 Mar 2022 04:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiCFECM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Mar 2022 23:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbiCFECL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Mar 2022 23:02:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AD3A22BC3
        for <linux-block@vger.kernel.org>; Sat,  5 Mar 2022 20:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646539279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qUTyaD+bXmHvCDNuEe4Fclwb9x3jzMuMtNnahDSRCug=;
        b=RhhTuyrvF8TPzx1MY9J69DLSyPIrXiNqogCDs3yS3wgPl+fAwp22fFVQaj+6l/dieefS6G
        pzFbxzy7Vy6OxeT6SKMFH9Ng4jj+NxIjeQ180HmVhTQHdKpBXVSbFSJAWk5oHWtr8q6KzQ
        a4xQyOzFxFfEVVP2quuzFDjnQYcalqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-VrTIo70fP5-YVJc_Eg7hFQ-1; Sat, 05 Mar 2022 23:01:14 -0500
X-MC-Unique: VrTIo70fP5-YVJc_Eg7hFQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81000824FA6;
        Sun,  6 Mar 2022 04:01:13 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FD4B5E483;
        Sun,  6 Mar 2022 04:01:09 +0000 (UTC)
Date:   Sun, 6 Mar 2022 12:01:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 08/14] sr: implement ->free_disk
Message-ID: <YiQyALQe3ZPWi0Pe@T590>
References: <20220304160331.399757-1-hch@lst.de>
 <20220304160331.399757-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304160331.399757-9-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 04, 2022 at 05:03:25PM +0100, Christoph Hellwig wrote:
> Simplify the refcounting and remove the need to clear disk->private_data
> by implementing the ->free_disk method.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

