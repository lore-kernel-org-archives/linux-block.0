Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7042DC76196
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 09:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjDKJLm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 05:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjDKJLM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 05:11:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A712D63
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 02:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681204203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+5pf1gCQ66bENTN9QciDqEokoMwoHIq83idReHgM/lk=;
        b=JKNTnj3TXL6r6vILjnulrjsW6VF/vTSqjlFeOfL6v0a8/RGyjGsHwyJXDm5mnTaOOshI+Z
        6xoz/GAImboORmLFJ0IEyELs561vdEImhHW4cSPuHxLo4d1UnFN4084LEBzuT20HiKiIOA
        nqY1qUbiONvQcUpAMESinKE+JaIV2es=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-Ivcg6dhKPd2a25ziE_5Acw-1; Tue, 11 Apr 2023 05:09:58 -0400
X-MC-Unique: Ivcg6dhKPd2a25ziE_5Acw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 588BC8996E9;
        Tue, 11 Apr 2023 09:09:57 +0000 (UTC)
Received: from mrjust8.localdomain.com (unknown [10.45.226.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BC6940C83A9;
        Tue, 11 Apr 2023 09:09:55 +0000 (UTC)
From:   Ondrej Kozina <okozina@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     bluca@debian.org, gmazyland@gmail.com, axboe@kernel.dk,
        hch@infradead.org, brauner@kernel.org, jonathan.derrick@linux.dev,
        Ondrej Kozina <okozina@redhat.com>
Subject: [PATCH v2 0/1] sed-opal: geometry feature reporting command
Date:   Tue, 11 Apr 2023 11:09:30 +0200
Message-Id: <20230411090931.9193-1-okozina@redhat.com>
In-Reply-To: <20230406131934.340155-1-okozina@redhat.com>
References: <20230406131934.340155-1-okozina@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While further testing various OPAL drives we have discovered that
some drives may impose alignment requirements that can not be
satisfied without reading some aditional parameters reported
by sed-opal iface.

We used to stick to physical block size reported by general block
device in place of LogicalBlockSize as reported by opal 'geometry',
but at least 2 aditional restrictions can not be easily mapped to
anything currently reported by block layer.

Without this patch we can not properly align locking ranges created
via sed-opal iface.

(Also it helps us to explain to userspace what went wrong)

Changes since previous version:

v2:
  - Mask proper bit for ALIGN value

Ondrej Kozina (1):
  sed-opal: geometry feature reporting command

 block/sed-opal.c              | 29 ++++++++++++++++++++++++++++-
 include/linux/sed-opal.h      |  1 +
 include/uapi/linux/sed-opal.h | 13 +++++++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

-- 
2.31.1

