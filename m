Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D30FEB64DD
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 17:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGURjS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 13:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGURjQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 13:39:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B7830D0
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 10:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689961111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cP/PP/j19pdxikIXdbVjAt1/1FQUYNYi1mA2xzgS7iw=;
        b=GINly6TeBxa8Lv0br6tMUYsafnmIcK6AMNmJ0lso9vb1XlX83mIl0c5H0FgUO2F7SiZpWk
        Oq+c2s2HkzFucvvsMFZMT8YghFXBHPQwQ+E8cftq2YNV6JN8L+zi/aj2zPHWI2LS8xMe7a
        eo7npQ3iDzVdWG+636M1nVKoeNdGKJU=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-efyqwQhaM8WzaJ8NqkqEjg-1; Fri, 21 Jul 2023 13:38:30 -0400
X-MC-Unique: efyqwQhaM8WzaJ8NqkqEjg-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-797185c81e3so529040241.2
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 10:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689961109; x=1690565909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cP/PP/j19pdxikIXdbVjAt1/1FQUYNYi1mA2xzgS7iw=;
        b=kq6Hs3dlQBxQGx9Z/NIECWDgmKsHnpeAqqjFUZb1AOfkTZlCqcSbruhmBCDWtcKGBr
         LxG1mQyMjme0GQi8Lihis7Uf1jTiQV8m64GJF4HHkwrO6Fj91o+hBdeQWKq9H2x9mFW7
         KVP5qD1oMqKOSSJ+zX2Q1Zx/0Fh8ApXNMzZMRXBR/WNPbUxTbn0wnEQdfv1JxhTRpUOO
         HzCAWRqLM6Xc7Q+ookhHKGQvgtpY6GdM3eSM+PW8JQd8x7Z0C4MZ/aa1XfrspuCCB94G
         jqBdWLABsKLxtEhxXsUs5efSSh9oxzUlQvq8pDkW4CIp/Ab6JjhbbVaMWSGjplR74ib/
         XqhQ==
X-Gm-Message-State: ABy/qLb8gs9LxpcNlJg5RbMRUzwEPDs8AR5fTmELOZKBB5WuSHRzhwuW
        SQ7lEnnwLg2eCyNgh2tBFIzJnUAW5OObbJu91SOJvuYXETIPkU2M0/Bqc001bZ/Y57k5Q1+cf7t
        XafJs9IWUJ3E95D/j+PW4nn/ioAkzX+RW+Occg/Swzw8e380fdQ==
X-Received: by 2002:a05:6102:451:b0:443:677e:246e with SMTP id e17-20020a056102045100b00443677e246emr640231vsq.5.1689961109265;
        Fri, 21 Jul 2023 10:38:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGoMa2vLIc0EmjM8eRrrhNYoPfV7JAtlk1Qd7sThaWS9dGOn3ldRtM3L6m9KaKcsElWN7PeKSDaST+YRKN7vwU=
X-Received: by 2002:a05:6102:451:b0:443:677e:246e with SMTP id
 e17-20020a056102045100b00443677e246emr640220vsq.5.1689961109063; Fri, 21 Jul
 2023 10:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230721095715.232728-1-ming.lei@redhat.com> <ZLpgk95AQSnKWg+o@kbusch-mbp.dhcp.thefacebook.com>
 <ZLpi9IVwJcK6hJvt@ovpn-8-26.pek2.redhat.com>
In-Reply-To: <ZLpi9IVwJcK6hJvt@ovpn-8-26.pek2.redhat.com>
From:   David Jeffery <djeffery@redhat.com>
Date:   Fri, 21 Jul 2023 13:38:17 -0400
Message-ID: <CA+-xHTGpzx=dfkJ9ukf4Z4aT7BrHZTfg+vCzKqjGyXid+E6+oA@mail.gmail.com>
Subject: Re: [RFC PATCH] sbitmap: fix batching wakeup
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 21, 2023 at 6:50=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Fri, Jul 21, 2023 at 12:40:19PM +0200, Keith Busch wrote:
> > On Fri, Jul 21, 2023 at 05:57:15PM +0800, Ming Lei wrote:
> > > From: David Jeffery <djeffery@redhat.com>
> >
> > ...
> >
> > > Cc: David Jeffery <djeffery@redhat.com>
> > > Cc: Kemeng Shi <shikemeng@huaweicloud.com>
> > > Cc: Gabriel Krisman Bertazi <krisman@suse.de>
> > > Cc: Chengming Zhou <zhouchengming@bytedance.com>
> > > Cc: Jan Kara <jack@suse.cz>
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >
> > Shouldn't the author include their sign off? Or is this supposed to be
> > from you?
>
> I understand signed-off-by needs to be explicit from David, and let's
> focus on patch itself. And I believe David can reply with his
> signed-off-by when the patch is ready to go.
>
>
> Thanks,
> Ming
>

Thank you for the initial checking of the patch, Ming. I appreciate
your patience and wisdom looking over my ideas. Please add my
signed-off-by to the patch.

Signed-off-by: David Jeffery <djeffery@redhat.com>

Regards,
David Jeffery

