Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:33633 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S946090AbcJaWyi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2016 18:54:38 -0400
MIME-Version: 1.0
In-Reply-To: <20161031152616.GB30919@infradead.org>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
 <1477728600-12938-5-git-send-email-tom.leiming@gmail.com> <20161031152616.GB30919@infradead.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 1 Nov 2016 06:54:36 +0800
Message-ID: <CACVXFVNKVp7rWkYnry+dDvvPWvht09gVCi+qHdaHipYF4yPS+Q@mail.gmail.com>
Subject: Re: [PATCH 04/60] block: floppy: use bio_add_page()
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 31, 2016 at 11:26 PM, Christoph Hellwig <hch@infradead.org> wrote:
> Why not keep the bio_add_page in the same spot as direct assignments
> were before?

I just want to put adding page after setting bi_bdev.

Thanks,
Ming Lei
