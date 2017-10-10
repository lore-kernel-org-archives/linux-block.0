Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:47854 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932619AbdJJSPb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Oct 2017 14:15:31 -0400
Received: by mail-pf0-f179.google.com with SMTP id z11so8124650pfk.4
        for <linux-block@vger.kernel.org>; Tue, 10 Oct 2017 11:15:31 -0700 (PDT)
Date: Tue, 10 Oct 2017 11:15:29 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Tom Nguyen <tom81094@gmail.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH V6 3/5] sbitmap: introduce __sbitmap_for_each_set()
Message-ID: <20171010181529.GC30738@vader.DHCP.thefacebook.com>
References: <20171009112424.30524-1-ming.lei@redhat.com>
 <20171009112424.30524-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171009112424.30524-4-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 09, 2017 at 07:24:22PM +0800, Ming Lei wrote:
> We need to iterate ctx starting from any ctx in round robin
> way, so introduce this helper.
> 
> Cc: Omar Sandoval <osandov@fb.com>

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  include/linux/sbitmap.h | 64 ++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 47 insertions(+), 17 deletions(-)
