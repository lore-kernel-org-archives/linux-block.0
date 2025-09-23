Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF29631DDB7
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617888; cv=none; b=Z2Xsh6237IMdaeNr1QCoxF/Q1gP+NKB3boeQ6etNvRsd0SH1xGScLQO7GuP5R1lWHkjQ/rBd2BRhZhEas7QLHAfFnssXqhTSkgt+4n4TTteJua1WjO1jlKHf41BQ1jwZzriyLmypp2n3HVdAtw0bucVB2y9OwSDumYIPrYraNKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617888; c=relaxed/simple;
	bh=yuRoN1dn+1f0JPOW4j/gikUrJeQUMtdVNWCmANVYwA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T75nFoAIl4fGcufLaWGRhjHTReCys4Lel4TFx0feWa1VbW2c8RQzp61las8AewCauA+2b9t/WWvDe3oiQ1gN0eaRKp4NK36f4u2/U5gstjkQiH1kHlbtObGONKb2QDELQ89zokIGqtthlldCE1Kfz8e/Jw5ULcrfiocwzOjSOug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cla9AxSm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cla9AxSm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758617885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yuRoN1dn+1f0JPOW4j/gikUrJeQUMtdVNWCmANVYwA4=;
	b=cla9AxSmwvYcMyPfpl+XuZ6lXI0bmsGA4mcDBS2IQD/2STfJLDdoUG1wtrqz9xhGk+IhaG
	3f9RYH5EwgLcFFgd8AuUGI1TnEMiS7vJ3WnL4KOJJjSv7NlJnUoKi3EsEv3O58kVv1Qe/O
	crfSsVUY27Bi66ySMn9UL+VAedo1jDA=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-oZbVgvnvPB-hqUMygjtQ4A-1; Tue, 23 Sep 2025 04:58:02 -0400
X-MC-Unique: oZbVgvnvPB-hqUMygjtQ4A-1
X-Mimecast-MFC-AGG-ID: oZbVgvnvPB-hqUMygjtQ4A_1758617882
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-555c71c82ddso915150137.3
        for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 01:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758617882; x=1759222682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuRoN1dn+1f0JPOW4j/gikUrJeQUMtdVNWCmANVYwA4=;
        b=JmvUYNMAY8y0RpXXsoh44uvMu9LK3eJMuzEXk1/c38xrrm5qJ3N0cxtPCgIMxi91Vd
         bDxteqXAky5ZdIZPbfXhuyPEpWJMo/lXbqPs9eTh48V9beK6CXmTQ3J4srHCERz4U3I6
         TcHeYBjuXs09Fr0kDUDtv9pB9YLVi9sMKQqh9d9dKW11j4pdvMV2s4ebc9cynZO2Xw6u
         qaIoLZNK5syzpA80ZGAqN5BkiVzVQYAV7CmjopTFszeqKISOpOKmihJ2+RWmE0pOOgny
         B1BDKd08gdbYWvJEbn5aONAhS9ECZpdj43K1zPYIMAQ9z39OVNOw1v++c/TPMHP7gIx6
         22lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTrZf26+CrvrFIqJUGfA2PXgFaTsuVpWxhQpoF5U4BqhC8211VrID6rC4dUAChupuOjfLlGrARKqYk4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTPwOtfq1plCUcYQOiy9Cl3gXUedmoRSDlGTxhP0i12Xt4gUXz
	uFewSYXsW8SmbMnlZxYpgAGnCUJGUyXEu2QeDQccrKj70iyGzNNYGI1hFlRojYhwno4aMWVRwyG
	bJDSXwKk48XMiC8OJEWHEvgEHowwyASNoSNStIadbZH0WljESKbV9mWFqpdl3pv/X1wBynqrtHw
	PICMKKikKqOmjPx4GpnfuU1RVt9nnpnu2AEAh2LT0=
X-Gm-Gg: ASbGncs4VhUZoxlnY2CSyYPOobK514JwZbiyKyE9JMZ/Lgmph5Z8NEniso77j0jNTV3
	ZkPSFGc+RzrPh2T4VbhlyPlJFKZZ4EGn4AuGWFo+1AOyOqJJ0bMl2jdq/U8tF7rbbiLqg6cURYx
	C/rCqj8IGjx0U2fljeYQgcIQ==
X-Received: by 2002:a05:6102:1610:b0:533:ff66:698c with SMTP id ada2fe7eead31-5a57e77391fmr588725137.2.1758617881717;
        Tue, 23 Sep 2025 01:58:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMg0OF+m3NO7yihYn0j1OQ6Ug6oQBHJjJXRrqGiDdaU1maoqXEtdKBL+w4PraBvKII/xnkas1KdvpyzDH3oAE=
X-Received: by 2002:a05:6102:1610:b0:533:ff66:698c with SMTP id
 ada2fe7eead31-5a57e77391fmr588715137.2.1758617881399; Tue, 23 Sep 2025
 01:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923070101.3507251-1-yukuai1@huaweicloud.com>
In-Reply-To: <20250923070101.3507251-1-yukuai1@huaweicloud.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 23 Sep 2025 16:57:50 +0800
X-Gm-Features: AS18NWAdzWR_qV7nOXeqhHug2ByGphmNpVqthkSHVtEUCe1xzom7oBjU8-rRLZo
Message-ID: <CAFj5m9JW9apD56=9m2jrr7Bza_L7+DfbeP6tMZhmWjyvRuL7ow@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: fix null-ptr-deref in blk_mq_free_tags() from
 error path
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, hare@suse.de, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 3:11=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> blk_mq_free_tags() can be called after blk_mq_init_tags(), while
> tags->page_list is still not initialized, causing null-ptr-deref.
>
> Fix this problem by initializing tags->page_list at blk_mq_init_tags(),
> meanwhile, also free tags directly from error path because there is no
> srcu barrier.
>
> Fixes: ad0d05dbddc1 ("blk-mq: Defer freeing of tags page_list to SRCU cal=
lback")
> Reported-by: syzbot+5c5d41e80248d610221f@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68d1b079.a70a0220.1b52b.0000.GAE@goog=
le.com/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,

