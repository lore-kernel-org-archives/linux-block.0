Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EE1C76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 13:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjDFNUy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 09:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238249AbjDFNUq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 09:20:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11D6903B
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680787182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2DFZI80QIOwvB8NOw3C3QCZHTvIhVpYDBSBlzEN1P6M=;
        b=fMe7TkeHM+29w+BMN5bbCCGZk+bhOF1AEdcLUOK/i3jdRifq7QkHXkIwWvidU2+90X6NLd
        zq1RjYIxhs7bQq4TOSWWezMD85POefiYEG6d+BBJPzvaXX7Jy5OPnHzLHUbpg9PVpHGx1N
        asMeYhAUw2nnk91AvejuVt5LH7M9w1o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-jkFQ7ViZN7SCuvCtOJhQ1Q-1; Thu, 06 Apr 2023 09:19:39 -0400
X-MC-Unique: jkFQ7ViZN7SCuvCtOJhQ1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E28EC884EC0;
        Thu,  6 Apr 2023 13:19:38 +0000 (UTC)
Received: from mrjust8.localdomain (unknown [10.43.17.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBC3C2027063;
        Thu,  6 Apr 2023 13:19:37 +0000 (UTC)
From:   Ondrej Kozina <okozina@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     bluca@debian.org, gmazyland@gmail.com, axboe@kernel.dk,
        hch@infradead.org, brauner@kernel.org, jonathan.derrick@linux.dev,
        Ondrej Kozina <okozina@redhat.com>
Subject: [PATCH 0/1] sed-opal: geometry feature reporting command
Date:   Thu,  6 Apr 2023 15:19:33 +0200
Message-Id: <20230406131934.340155-1-okozina@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

Ondrej Kozina (1):
  sed-opal: geometry feature reporting command

 block/sed-opal.c              | 29 ++++++++++++++++++++++++++++-
 include/linux/sed-opal.h      |  1 +
 include/uapi/linux/sed-opal.h | 13 +++++++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

-- 
2.31.1

