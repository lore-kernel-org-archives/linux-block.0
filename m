Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33394 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S947917AbcJaXI7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2016 19:08:59 -0400
MIME-Version: 1.0
In-Reply-To: <20161031153321.GI30919@infradead.org>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
 <1477728600-12938-17-git-send-email-tom.leiming@gmail.com> <20161031153321.GI30919@infradead.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 1 Nov 2016 07:08:58 +0800
Message-ID: <CACVXFVPOAZgO59n5XShLdPTtz38=_n8aF4sTGFtXL0XaDDjfGg@mail.gmail.com>
Subject: Re: [PATCH 16/60] block: pktcdvd: comment on direct access to bvec table
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 31, 2016 at 11:33 PM, Christoph Hellwig <hch@infradead.org> wrote:
> Please pick up my "pktcdvd: don't scribble over the bvec array"
> patch instead of the pktcdvd patches in this series.

OK.

Thanks,
Ming Lei
