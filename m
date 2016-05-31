Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v6 8/8] block: mark BIO_MAX_SIZE as obsolete
To: Ming Lei <ming.lei@canonical.com>, Jens Axboe <axboe@fb.com>,
 linux-kernel@vger.kernel.org
References: <1464615294-9946-1-git-send-email-ming.lei@canonical.com>
 <1464615294-9946-9-git-send-email-ming.lei@canonical.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Keith Busch <keith.busch@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kent Overstreet <kent.overstreet@gmail.com>,
 Mike Snitzer <snitzer@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <574DB6D6.20103@kernel.dk>
Date: Tue, 31 May 2016 10:07:50 -0600
MIME-Version: 1.0
In-Reply-To: <1464615294-9946-9-git-send-email-ming.lei@canonical.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/30/2016 07:34 AM, Ming Lei wrote:
> Some in-tree drivers may use big bio which size is more
> than BIO_MAX_SIZE, also the macro is seldom used in tree.
>
> So mark it as obsolete now, and it doesn't make sense
> after multipage bvec is introduced.

Is it used in the tree after the patchset? If not, kill it, there's no 
such thing as a deprecated/obsolete define.

-- 
Jens Axboe
