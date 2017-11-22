Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f43.google.com ([209.85.160.43]:39151 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdKVE5n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Nov 2017 23:57:43 -0500
Received: by mail-pl0-f43.google.com with SMTP id l16so143254pli.6
        for <linux-block@vger.kernel.org>; Tue, 21 Nov 2017 20:57:42 -0800 (PST)
Subject: Re: [PATCH] bcache: return IOERR to upper layer when read request
 meet metadata error
To: Rui Hua <huarui.dev@gmail.com>, Coly Li <i@coly.li>
Cc: linux-bcache <linux-bcache@vger.kernel.org>,
        linux-block@vger.kernel.org
References: <CAPGwLLOXh7-T7HtXGWRTAuLh3La-njWtv44dgPZXUfbrUod1zA@mail.gmail.com>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <f42404a8-9b57-7805-964e-250e5f9f842e@lyle.org>
Date: Tue, 21 Nov 2017 20:57:40 -0800
MIME-Version: 1.0
In-Reply-To: <CAPGwLLOXh7-T7HtXGWRTAuLh3La-njWtv44dgPZXUfbrUod1zA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Rui Hua--

Thank you for fixing this.

On 11/21/2017 05:58 AM, Rui Hua wrote:
> The read request might meet error when searching the btree, but the error was
> not handled in cache_lookup(), and this kind of metadata failure will not go
> into cached_dev_read_error(), finally, the upper layer will receive bi_status=0.
> In this patch we judge the metadata error by the return value of
> bch_btree_map_keys(), there are two potential paths give rise to the error:
> 1.Because the btree is not totally cached in memery, we maybe get error when
>   read btree node from cache device (see bch_btree_node_get()), the likely
>   errno is -EIO, -ENOMEM
> 2.When read miss happend, bch_btree_insert_check_key() will be called to
>   insert a "replace_key" to btree(see cached_dev_cache_miss(), just for doing
>   preparatory work before insert the missed data to cache device), a failure
>   can also happen in this situation, the likely errno is -ENOMEM
> bch_btree_map_keys() will return MAP_DONE in normal scenario, but we will
> get either -EIO or -ENOMEM in above two cases. if these happend, we should
> NOT recover data from backing device (when cache device is dirty) because
> we don't know whether bkeys the read request covered are all clean.
> And after that happend, s->iop.status is still its initially value(0)
> before we submit s->bio.bio, we set it to BLK_STS_IOERR, so it can go into
> cached_dev_read_error(), and finally it can be passed to upper layer,
> or recovered by reread from backing device.
> 
> Signed-off-by: Hua Rui <huarui.dev@gmail.com>

This preliminarily LGTM-- I have added it to my tree, though I plan to
make another review pass through all of the error path here.

Reviewed-by: Michael Lyle <mlyle@lyle.org>

Mike
