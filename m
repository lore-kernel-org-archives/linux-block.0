Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C66C761A6
	for <linux-block@archiver.kernel.org>; Mon,  3 Apr 2023 14:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjDCOZw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Apr 2023 10:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbjDCOZv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Apr 2023 10:25:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9CB2B0D6;
        Mon,  3 Apr 2023 07:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=tPLcLIMQuTkpwt1uxM6/NR9e+5ws7a0VS6jnQRtPH08=; b=Mh/k+rFpGlTmouG9aSBAmjU9Dl
        CkQCmtpT0He99s6WHpRflV9v8qXpw9cU6/fi9W8EdXcHATsJ4Lj/5eLNXcOaxjDRvRFd7S1gtaimN
        oa5dtbsdhKrUDr1+ngB8HqdhtLj4TLDAZAWIq8Hxere6rv6/jH2IFrK7S96vI7rDZJz4a1pu6gsYS
        LfrvuyfyToaiPkU2iRBbQO/2k6XG3rHEb6RnzQtL6WyPcPwtxCOKzKAGdRvY/7qkSN84UI22S3YEx
        Ia2lIOiQNVQZ9mRW4yatYeRXaIBaxM48cXMT6CBcxUFuUhBAoOHCWWsiYAqJTRqFRdQotzLFWzSHr
        iF0dk39g==;
Received: from [2001:4bb8:191:a744:529d:286f:e3d8:fddb] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjL7z-00Fdkt-2n;
        Mon, 03 Apr 2023 14:25:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     dhowells@redhat.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: two little cleanups for the for-6.4/splice branch
Date:   Mon,  3 Apr 2023 16:25:40 +0200
Message-Id: <20230403142543.1913749-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series removes two now unused functions.
