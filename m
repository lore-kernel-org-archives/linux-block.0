Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0027EC7EE22
	for <linux-block@archiver.kernel.org>; Fri, 21 Apr 2023 21:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbjDUVoW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Apr 2023 17:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjDUVoS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2023 17:44:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25F21FC6;
        Fri, 21 Apr 2023 14:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Pwtny366FbTbrb7vPgMXDOxfQYz6bsR4vwvBIbUUYzg=; b=l1UKRS+6uYC4EXAjJgBrQTAp5j
        xsYvwCnnNonL+zWZMEy71A3Ta6km8F6dSzKQvEcpRo5TV7XBXl9OERI0fsz5C845ifOI1VFCEHRc1
        Zre0qUD7V89WFxot/x0Dllx9YnFxYQ7Yz7zDqe598RN0r0tdnLI/4pmF0Tvd/CygY81NUfyF7TcfO
        R1q/JTspIPOKlYq6NoZibJ4hLTLlDqaLHYjGQRhRwv9u7o7cGbziZ6ambxSZLU25fgMv7Z5We7Z9g
        4m2TriUxFygO3OJdPvzDe0pBPp5xw1iklrlut7//xUpzOnTPbemmyDvmuxTGhDtulG3XxP+CyxfK9
        9RMFdwJQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppyY1-00Btok-1t;
        Fri, 21 Apr 2023 21:44:05 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, djwong@kernel.org
Cc:     p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, hare@suse.de, kbusch@kernel.org,
        mcgrof@kernel.org, patches@lists.linux.dev,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC 2/8] shmem: convert to use folio_test_hwpoison()
Date:   Fri, 21 Apr 2023 14:43:54 -0700
Message-Id: <20230421214400.2836131-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230421214400.2836131-1-mcgrof@kernel.org>
References: <20230421214400.2836131-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The PageHWPoison() call can be converted over to the respective folio call
folio_test_hwpoison(). This introduces no functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/shmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 5bf92d571092..6f117c3cbe89 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3483,7 +3483,7 @@ static const char *shmem_get_link(struct dentry *dentry,
 		folio = filemap_get_folio(inode->i_mapping, 0);
 		if (IS_ERR(folio))
 			return ERR_PTR(-ECHILD);
-		if (PageHWPoison(folio_page(folio, 0)) ||
+		if (folio_test_hwpoison(folio) ||
 		    !folio_test_uptodate(folio)) {
 			folio_put(folio);
 			return ERR_PTR(-ECHILD);
@@ -3494,7 +3494,7 @@ static const char *shmem_get_link(struct dentry *dentry,
 			return ERR_PTR(error);
 		if (!folio)
 			return ERR_PTR(-ECHILD);
-		if (PageHWPoison(folio_page(folio, 0))) {
+		if (folio_test_hwpoison(folio)) {
 			folio_unlock(folio);
 			folio_put(folio);
 			return ERR_PTR(-ECHILD);
@@ -4672,7 +4672,7 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 		return &folio->page;
 
 	page = folio_file_page(folio, index);
-	if (PageHWPoison(page)) {
+	if (folio_test_hwpoison(folio)) {
 		folio_put(folio);
 		return ERR_PTR(-EIO);
 	}
-- 
2.39.2

