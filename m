Return-Path: <linux-block-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:40898 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753812AbeE1H3q (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 May 2018 03:29:46 -0400
Subject: Re: [RESEND PATCH V5 24/33] f2fs: conver to bio_for_each_page_all2
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Kent Overstreet" <kent.overstreet@gmail.com>
CC: David Sterba <dsterba@suse.cz>, Huang Ying <ying.huang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>
References: <20180525034621.31147-1-ming.lei@redhat.com>
 <20180525034621.31147-25-ming.lei@redhat.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <5cb89f28-9f7d-7423-b0a0-2b217a406738@huawei.com>
Date: Mon, 28 May 2018 15:29:38 +0800
MIME-Version: 1.0
In-Reply-To: <20180525034621.31147-25-ming.lei@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2018/5/25 11:46, Ming Lei wrote:
> bio_for_each_page_all() can't be used any more after multipage bvec is
> enabled, so we have to convert to bio_for_each_page_all2().
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Acked-by: Chao Yu <yuchao0@huawei.com>

Thanks,
