Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D594C433EF
	for <linux-block@archiver.kernel.org>; Sun, 26 Sep 2021 01:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E406108B
	for <linux-block@archiver.kernel.org>; Sun, 26 Sep 2021 01:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhIZBoq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 25 Sep 2021 21:44:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54503 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229989AbhIZBop (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Sep 2021 21:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632620589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QlYPsugeL/4kemew+uifgGLLhcpY/mZxCK1RAZ1E5aI=;
        b=avovCTSzmBDsN7lhd88OBl1Qzlqsfi6tzppyWqumVFD6z7UI6/vnKdi73ioj1t4Mz+eN28
        QlLrZK668oVuXamhr9I54Ru1IhEaLJYxspUH+WMJp0KINPb/Y5H6THyR3Lrom1noRlpoRu
        Od9KT4PuO/8CTkD26BKLlAILMEtWz2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9--840KwkiPLOK-LGT-pza1A-1; Sat, 25 Sep 2021 21:43:06 -0400
X-MC-Unique: -840KwkiPLOK-LGT-pza1A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22750835DE0;
        Sun, 26 Sep 2021 01:43:05 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B0636B545;
        Sun, 26 Sep 2021 01:42:57 +0000 (UTC)
Date:   Sun, 26 Sep 2021 09:43:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        hare@suse.de
Subject: Re: [PATCH v4 08/13] blk-mq: Don't clear driver tags own mapping
Message-ID: <YU/QMLnZP6N1aI5z@T590>
References: <1632472110-244938-1-git-send-email-john.garry@huawei.com>
 <1632472110-244938-9-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632472110-244938-9-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 24, 2021 at 04:28:25PM +0800, John Garry wrote:
> Function blk_mq_clear_rq_mapping() is required to clear the sched tags
> mappings in driver tags rqs[].
> 
> But there is no need for a driver tags to clear its own mapping, so skip
> clearing the mapping in this scenario.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

