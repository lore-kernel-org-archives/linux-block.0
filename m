Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F726221FBD
	for <linux-block@vger.kernel.org>; Sat,  4 Oct 2025 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759588957; cv=none; b=R3EvBSNURHLD37MHBx291E0ZphvcdG3Uo4+unZtnUu5DjrDEvEcSXvrvWONxQuaRd5j1W1vqaBdmAQoPExxPysxvAgSAhLu0m35ulY4GX21CKG8YbDKfneNUeq7Ze3OnrJE187gnwfqxZaVYj5iaN8kq4Qx+0jLR19ThSSHP7js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759588957; c=relaxed/simple;
	bh=NANl0qhN8cP6dUJGh6KczJhxCiKXgeWk3FtwYPrEs1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXan98dtL8tpw6jbpsCg9Q7VBzJO+zvo05FHa+Jox7x2GNFSh4NCeEhLAzcaxxqKFHLkhbbIrD/DAfq8VGwT1ynpr0U5rWptBVmprrP4ra6IT83fzWUth6oq03mfEccbATjt5JNGWT2uJ+i8XZOwNrVRakIamTOHQ7G641RrT5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DcKyi4/D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DcKyi4/D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759588954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CyNXhoET8XBzKUh2zjz0wNQO0kAUQdnWpZGZ78YY6qY=;
	b=DcKyi4/DPmWMXlHnfW7ss+M+EMPJNcjglLy6BCStAiEy+0YUu/Mw808kIwRv84gupx896e
	2Jt6LBlAC7WTwiQIYxKa+xC3M4yGMq7KeJsfWP9Ue+h7nvg2AIjO1sEkS9gKh9ldQTePQ6
	spq/8vNiySW2PeohP4dTPoMX78UteTw=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-94y5QHm0M5qKNluvGUNfPQ-1; Sat, 04 Oct 2025 10:42:32 -0400
X-MC-Unique: 94y5QHm0M5qKNluvGUNfPQ-1
X-Mimecast-MFC-AGG-ID: 94y5QHm0M5qKNluvGUNfPQ_1759588952
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-90bceb0908eso4360602241.0
        for <linux-block@vger.kernel.org>; Sat, 04 Oct 2025 07:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759588952; x=1760193752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyNXhoET8XBzKUh2zjz0wNQO0kAUQdnWpZGZ78YY6qY=;
        b=q389YdVh4BbfFMgtAnQlgYXqODWh8fOtfn6SQRTpLJFXA7SO7r7m9tiN82F6Aa1WfG
         05L+6UQEYxqIBEul5W+TdzJA4SwHJtheewWHb+Ui4+lOS52x9dxlYwvLKOnpF5Hyi+vD
         +ojP45sQCYne5MTC3KXWK9twnpieyvPFcYsyP1r6n11RI+kFOInJs9QOzizLmND/4KIy
         PHMtU4AeITCgabNey6YHRjCezYWM5Mntf/6p2IHd5nidfNjhbIkYx6mKJwJ6wX4VLamr
         7TvGEhhLkih68Rus3PCNJxSmWG0jOYDNG2qSYv+PhY886vDXFsKeKtSRDJJ6Kqq7QcoC
         OYSA==
X-Forwarded-Encrypted: i=1; AJvYcCXItodXaupfMSzPi/J0JtdGl6Mq4sePQAvNfLaw8Z2isAQWdLL100F1lkS26AshelC6NyptPpp8CbAMcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKOcSWi412o5cjzmOQ7qqyGQWehEnG9ygFTzS6Z6CIGDfe6mcZ
	qgleeJRmgKk1Ahl02GgnCbe0NmA0QatEtsi2qRVfrWNbwaL5YI8ziqQzBqOlUW91zHMofRzJE1j
	9yaQaE7TH5GVNchQwLDGKxq8OkLnWSOlOCo0+lSFVHC89ov0Y6Kuz4XmuMh1Br1daY/aE/dmPPC
	yWkfLzaxBKY5WoKkTaTEUoWvdo3SCSrjb1kvVug1g=
X-Gm-Gg: ASbGncu6AxtwR6KODV/iKaDmFl/9v2Ch8yt9VVxWLOmI8GzHKbT1J/yEX6FNV4owr/F
	EBmRf5Ga+t1wjXb6rNM4IiPR2X7WxVxvTEfC0XZxdb1chXuvvo6ja3WKBydU2HZAcnY6CQvPfTX
	EJ2x9zZp3DO4aMg7JKJp+ddnKKU88=
X-Received: by 2002:a05:6102:14a8:b0:52a:1104:3029 with SMTP id ada2fe7eead31-5d41c17fc59mr3321316137.17.1759588951968;
        Sat, 04 Oct 2025 07:42:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE674zB73YsI/pAPw0bIwRieKGfGydQY5l1hK3XQdGD80Jtss5WI0eIO6jsU5dAUs3XNCmSrqmU+56s4D9SKSQ=
X-Received: by 2002:a05:6102:14a8:b0:52a:1104:3029 with SMTP id
 ada2fe7eead31-5d41c17fc59mr3321306137.17.1759588951602; Sat, 04 Oct 2025
 07:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830021825.2859325-1-ming.lei@redhat.com> <20250830021825.2859325-6-ming.lei@redhat.com>
 <pnezafputodmqlpumwfbn644ohjybouveehcjhz2hmhtcf2rka@sdhoiivync4y>
In-Reply-To: <pnezafputodmqlpumwfbn644ohjybouveehcjhz2hmhtcf2rka@sdhoiivync4y>
From: Ming Lei <ming.lei@redhat.com>
Date: Sat, 4 Oct 2025 22:42:20 +0800
X-Gm-Features: AS18NWDHJgRWziKexb0Mjrgc7I5f0NwDaDeOyWw9X3169ZFewY53f1xPhcN8YcQ
Message-ID: <CAFj5m9Ki1U6N4N6-=HYy49KfvYAbegmwcXLuKCxjX4E+qy7u7Q@mail.gmail.com>
Subject: Re: [PATCH V2 5/5] blk-mq: Replace tags->lock with SRCU for tag
 iterators - Rockchip UFS regression
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Hannes Reinecke <hare@suse.de>, Yu Kuai <yukuai3@huawei.com>, kernel@collabora.com, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 1:18=E2=80=AFAM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Sat, Aug 30, 2025 at 10:18:23AM +0800, Ming Lei wrote:
> > Replace the spinlock in blk_mq_find_and_get_req() with an SRCU read loc=
k
> > around the tag iterators.
> >
> > This is done by:
> >
> > - Holding the SRCU read lock in blk_mq_queue_tag_busy_iter(),
> > blk_mq_tagset_busy_iter(), and blk_mq_hctx_has_requests().
> >
> > - Removing the now-redundant tags->lock from blk_mq_find_and_get_req().
> >
> > This change fixes lockup issue in scsi_host_busy() in case of shost->ho=
st_blocked.
> >
> > Also avoids big tags->lock when reading disk sysfs attribute `inflight`=
.
> >
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
>
> This patch landed in the last few hours and I now see the following
> fatal error on the Radxa ROCK 4D (most likely Rockchip UFS in
> general). After reverting this patch the error is gone and things
> are working as expected:
>
> [    2.713204] CPU: 7 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.17.0-g4=
72ea195cdf3 #1 PREEMPT
> [    2.713956] Hardware name: Radxa ROCK 4D (DT)
> [    2.714342] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [    2.714955] pc : __srcu_read_lock+0x30/0x80

  The problem: scsi_host_busy() tries to use tags_srcu before it's
initialized by init_srcu_struct().

  The warning at __srcu_read_lock+0x30/0x80 indicates that the SRCU
structure (tags_srcu) has not been properly initialized yet. The code
   at line 754 in srcutree.c tries to read ssp->srcu_ctrp, but this
pointer is likely NULL or contains garbage because init_srcu_struct()
   hasn't been called yet.

  Solution

  The scsi_host_busy() call should only happen after the SCSI host has
been added and the tag_set has been initialized. The fix would be
  to check if the tag_set is initialized before calling
scsi_host_busy(), or to defer the printing of host state until after
the host is
  fully initialized.

  One possible fix is to check hba->scsi_host_added before calling
scsi_host_busy():

  dev_err(hba->dev, "%d outstanding reqs, tasks=3D0x%lx\n",
      hba->scsi_host_added ? scsi_host_busy(hba->host) : 0,
      hba->outstanding_tasks);

