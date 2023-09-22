Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906F6CD4945
	for <linux-block@archiver.kernel.org>; Fri, 22 Sep 2023 12:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjIVMDk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Sep 2023 08:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbjIVMDh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2023 08:03:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCA61A1
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2023 05:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695384164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7BA8QLNemiJIXUC+XXC0PAivfRO0j2uaFr7AQHg4nPM=;
        b=IRx7GXIGJkFUV8slMfO0joaakyX03lhjwcKa3168wfsALPG/OMIA6mE/V3Uh/2UaJQtyg2
        mMpaNLusO4gcIlb24nldK8WuhPKke+zi89+MZZmhXoAUBS5xNRqT4uPLyzmU3F3+tMKWzn
        RKAGi7xMtZJ6816InyjbOzkdCAo5X0Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-VMVqFlzOOAy8DJUDv5pSRw-1; Fri, 22 Sep 2023 08:02:41 -0400
X-MC-Unique: VMVqFlzOOAy8DJUDv5pSRw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CD583816C82;
        Fri, 22 Sep 2023 12:02:40 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 590362156701;
        Fri, 22 Sep 2023 12:02:37 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.de>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v6 03/13] sound: Fix snd_pcm_readv()/writev() to use iov access functions
Date:   Fri, 22 Sep 2023 13:02:17 +0100
Message-ID: <20230922120227.1173720-4-dhowells@redhat.com>
In-Reply-To: <20230922120227.1173720-1-dhowells@redhat.com>
References: <20230922120227.1173720-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix snd_pcm_readv()/writev() to use iov access functions rather than poking
at the iov_iter internals directly.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Suren Baghdasaryan <surenb@google.com>
cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
cc: alsa-devel@alsa-project.org
---
 sound/core/pcm_native.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index bd9ddf412b46..9a69236fa207 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3527,7 +3527,7 @@ static ssize_t snd_pcm_readv(struct kiocb *iocb, struct iov_iter *to)
 	if (runtime->state == SNDRV_PCM_STATE_OPEN ||
 	    runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
-	if (!to->user_backed)
+	if (!user_backed_iter(to))
 		return -EINVAL;
 	if (to->nr_segs > 1024 || to->nr_segs != runtime->channels)
 		return -EINVAL;
@@ -3567,7 +3567,7 @@ static ssize_t snd_pcm_writev(struct kiocb *iocb, struct iov_iter *from)
 	if (runtime->state == SNDRV_PCM_STATE_OPEN ||
 	    runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
-	if (!from->user_backed)
+	if (!user_backed_iter(from))
 		return -EINVAL;
 	if (from->nr_segs > 128 || from->nr_segs != runtime->channels ||
 	    !frame_aligned(runtime, iov->iov_len))

