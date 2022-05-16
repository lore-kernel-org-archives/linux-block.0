Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF2BC433EF
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 06:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbiEPGLo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 02:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbiEPGLn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 02:11:43 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5434820F46
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 23:11:42 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id z2so26569383ejj.3
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 23:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DDExltmJQGWG8ic0QFjNHARbqgfVm/8EvRKattKCXjs=;
        b=f+41nxPmWnF4eQ8C/CVQ5hE4qfEnRFusvKVYHkEZaBfWz8utQy293dT1v5CxIMxyL+
         UURKJ2FwAbMog5CbRi7nTUDI7llzpk7lZeaRFW7uVT5kiXaR2/9UoLLGpiHb/8I6WVjH
         jnqtqAasuLnJ0riAjZwXrsB/NGGdZhkEdKYDvzlC5MIJ7pIYNXeY69qhVnhWQ4XEsxs2
         mTPSrqZLTfcisM8WVUhHcqgaCRKq4wI1hOfxjtuXWGFlPE5JnmK20AcnjDdn0xSHFrP+
         WKJhymKRarwN1LFtNZt/UV7zIBG5tSTG43j6ko1YzXwTe7cpLf+rcHoIlhemVbapqMgx
         +Xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DDExltmJQGWG8ic0QFjNHARbqgfVm/8EvRKattKCXjs=;
        b=xqYQfEw2X7ialq3T73AWiXp9Kr2m7/z4zI48dCZZ4vRJOLa10LNfHbiZ/oWkMswfJ0
         s/xfuiAde8DkzNeMGV4HPkQRCtY81RPccyUWjBH/kioCcyqONr8eqX0AJYaCzSM4I/T5
         zrqc46p+i19PJOecxufim1/Jgh7UOL9LZFsZjL5l1cgNqm3RNC8WTvTegZNCLfsCWrWv
         YGlinfVJYGapjDg/4kOlfD08RZK3zYFv30SFTFuGE05Ym0jz39v0SiC5299AJI0auC5Q
         aVnadKM5GxwnASMnlB28abLvTf6/8IguXW/ZqV52bxg6+atMvqawBSa/4mh5G7iYygPq
         g0FQ==
X-Gm-Message-State: AOAM531rVKAWnzU3ZPByoNAe3dDEGjAI7jiTiwvhz9j9RR+xHkM63wad
        ZPsTanxehlsPCam9QM6xvIK9FIxlC2W8beiEfdZz
X-Google-Smtp-Source: ABdhPJybCyLqJWcm+ZRVJlnC9wn0Dk0JLtZaGocnjGqN649cF0rUiNK7Asn9oRZzaYCkJCV+17iuWsLc509n8gl1Hxw=
X-Received: by 2002:a17:906:7c96:b0:6f3:b6c4:7b2 with SMTP id
 w22-20020a1709067c9600b006f3b6c407b2mr13937840ejo.676.1652681500741; Sun, 15
 May 2022 23:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220322080639.142-1-xieyongji@bytedance.com> <Yjop+VdZi5xbHe+b@localhost.localdomain>
In-Reply-To: <Yjop+VdZi5xbHe+b@localhost.localdomain>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 16 May 2022 14:12:22 +0800
Message-ID: <CACycT3v=Gef6XyUN2=fAwV0+x+h5aeVF-z95=bbU1ziZ1oA9zw@mail.gmail.com>
Subject: Re: [PATCH] nbd: Fix hung on disconnect request if socket is closed before
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org,
        =?UTF-8?B?5b6Q5bu65rW3?= <zero.xu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ping.

On Wed, Mar 23, 2022 at 3:56 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Tue, Mar 22, 2022 at 04:06:39PM +0800, Xie Yongji wrote:
> > When userspace closes the socket before sending a disconnect
> > request, the following I/O requests will be blocked in
> > wait_for_reconnect() until dead timeout. This will cause the
> > following disconnect request also hung on blk_mq_quiesce_queue().
> > That means we have no way to disconnect a nbd device if there
> > are some I/O requests waiting for reconnecting until dead timeout.
> > It's not expected. So let's wake up the thread waiting for
> > reconnecting directly when a disconnect request is sent.
> >
> > Reported-by: Xu Jianhai <zero.xu@bytedance.com>
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
> Thanks,
>
> Josef
