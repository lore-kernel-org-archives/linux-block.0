Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48115C77B76
	for <linux-block@archiver.kernel.org>; Fri, 21 Apr 2023 22:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbjDUWt7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Apr 2023 18:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjDUWt6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2023 18:49:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F42E60;
        Fri, 21 Apr 2023 15:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Rk/OYWhW/XAI/I4YNvgkI3t2ZA+2S6o9dTT4l5mLGUU=; b=EDk6d+sAzT9ozbYKqvEeLRubE3
        G/qot7oj55X3AiaR2lLLm8yBh8BW3+E56dNXdljzVphWA+lV6sKfQ/0It6JkKoIFogYP5TAtrtu6q
        i/jd4HkFuKTz2kKi+bKR2g2GByNuISpDskvAbg4Wu/XE4Xgah+lEdR6pdxWq/7QHS0S2peABzdybd
        qBl9BTxmUjHUI81U7fNU2PXG7Lx4Ef2yGHI7lJZuKxQ/uAYWGjxRoBo/GVDRjTt5mwSwWov9aQBKO
        RBhTRZHrRSxSccSeyYa41TlJt/1dnR9ZVebBspme9XrLyJMAmQxfE5qxmCe2/UjkutydDYtGSOzYH
        WS6elVnQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ppzZX-00FiQg-N7; Fri, 21 Apr 2023 22:49:43 +0000
Date:   Fri, 21 Apr 2023 23:49:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, brauner@kernel.org,
        djwong@kernel.org, p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, hare@suse.de, kbusch@kernel.org,
        patches@lists.linux.dev, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 4/8] shmem: add helpers to get block size
Message-ID: <ZEMTB4uKgKJKQRHo@casper.infradead.org>
References: <20230421214400.2836131-1-mcgrof@kernel.org>
 <20230421214400.2836131-5-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421214400.2836131-5-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 21, 2023 at 02:43:56PM -0700, Luis Chamberlain wrote:
>  struct shmem_sb_info {
> +#ifdef CONFIG_TMPFS
> +	u64 blocksize;
> +#endif

u64?  You're planning on supporting a blocksize larger than 2GB?

I would store block_order (in an unsigned char) and then you can avoid
the call to ffs(), at the expense of doing 1UL << sbi->block_order;

