Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QChhmL5E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A32D51
	for <linux-block@vger.kernel.org>; Wed,  6 Dec 2023 22:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701928969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/XqCkGwetPERlH8LTIVNcKw64vcUuQSwWmVxlaN7SM=;
	b=QChhmL5E4hLNRBQ9PtB2SCfVoBbX5YA6aatn0WooLhHfdp39mnu3H64/KdfwCGWPvwPdSO
	GhExH3dMlqey3qX3ZkkoE79jswNv6eqhKehcyUQ6obLfEeD5z6bq1k3mfJrzY5/6zV2Btl
	EVoXIdvpuLiQ0UfS4vNxEyxA0iuDaOM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-mL2ynSdeNfi0v_F8QSvEnw-1; Thu, 07 Dec 2023 01:02:48 -0500
X-MC-Unique: mL2ynSdeNfi0v_F8QSvEnw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1d068f02fc7so7016405ad.1
        for <linux-block@vger.kernel.org>; Wed, 06 Dec 2023 22:02:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701928967; x=1702533767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/XqCkGwetPERlH8LTIVNcKw64vcUuQSwWmVxlaN7SM=;
        b=kTgZS5TrTi8auqxB4AUdz/MtX1RLQpgPL5+OAznW/3DaJ/vrNSCT0ixXEfxLh5WGOv
         2PVbqpcGWfCs0oU56uVznLIRQxkxJfVVpy+GHGXECqrqBnDHNQ1M3G2BXLM+uln+MNUN
         dy6uK32HMwsFMeJb+XvyreUMCDEWxcoEikA/Pkodw5akqz7AB4+eujDb7qnE/ChGPvPM
         NfUUnWunNshXoS4GaKjkqmilLDSSnKUxFrjaO0Pjl5u+GpTzF253g0QHiKGiXWsmJ0tY
         xLJOT1tcuog9mkZdOqqA0qJGE36Ujx8xAmQB9o96ntYS7pq9IZOoh9a/zpHSoYWcTLe+
         9xZw==
X-Gm-Message-State: AOJu0Yyy1TzwoIVWyMxQKe/qC2ZSGeFaRL0E3j0svdKAEYSe1uE59aQj
	3Gil6Q5v1z5HoEGEb6Hpi0ILqRBiGEhrtXduMKOOsY4KvQUCChgazY4kxlx/toUp3Kc+vo1q8hm
	ZgywiKQF9B6mAf9G3m1OBmlpRDFpOBaRssqUccpU=
X-Received: by 2002:a17:903:228e:b0:1d0:9c53:9cca with SMTP id b14-20020a170903228e00b001d09c539ccamr1954632plh.96.1701928967273;
        Wed, 06 Dec 2023 22:02:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGownq1ugLEOsfZ1cOJOiCkaYo93T8MWTSEJJFK0j1YeFaEDArhl552qEMO2cfTnbzOgcp/3YMGRbZyZbgPil0=
X-Received: by 2002:a17:903:228e:b0:1d0:9c53:9cca with SMTP id
 b14-20020a170903228e00b001d09c539ccamr1954622plh.96.1701928967048; Wed, 06
 Dec 2023 22:02:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207043118.118158-1-fengli@smartx.com>
In-Reply-To: <20231207043118.118158-1-fengli@smartx.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 7 Dec 2023 14:02:36 +0800
Message-ID: <CACGkMEt4_T5-aArkS4LOQsndwrMkjm_K-uPjdFnNRvwknQPaPg@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
To: Li Feng <fengli@smartx.com>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 12:33=E2=80=AFPM Li Feng <fengli@smartx.com> wrote:
>
> virtio-blk is generally used in cloud computing scenarios, where the
> performance of virtual disks is very important. The mq-deadline scheduler
> has a big performance drop compared to none with single queue.

At least you can choose the scheduler based on if mq is supported or not?

Thanks

