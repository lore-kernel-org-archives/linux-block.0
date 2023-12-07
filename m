Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="w/HO0722"
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B60BD5C
	for <linux-block@vger.kernel.org>; Wed,  6 Dec 2023 22:31:54 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6ce4d4c5ea2so253349b3a.0
        for <linux-block@vger.kernel.org>; Wed, 06 Dec 2023 22:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701930714; x=1702535514; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sR3A/v+kbUHDSu2DdKsZWsAH0wB0wI+BlWPsNGRqLQ=;
        b=w/HO0722I0VJSI72nJ/NFY9fPObBJN9xOa0PBadXZ8LRZai+KiFEeaPJKxTs0LtQ8p
         zjOcJQld4y33RWihJLiTCrQIA7DItMYajG1szjm9x+Od8y5oYUKSGxXtyuGoNmo+KcqG
         RrimeWCQ2QawNy7zQoXjzySrdU0PkMKUU68g5xAS+PxvaBo5Exdx5lBgjrKp1kvPGhvb
         qa/m33BsolzF0+F1nkoMNVlzc4V3abervsK2AcN9v5qG0hvUFQvimqFF+k7VONoDAYib
         R8d7IqLpsPPlkcIykv27MRLxdivMzKWzUmmkSvh+h0VxvwH5tzE2PKxZMcxgkOV71Pnr
         Ipag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701930714; x=1702535514;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sR3A/v+kbUHDSu2DdKsZWsAH0wB0wI+BlWPsNGRqLQ=;
        b=UGpXRsDYsYHi7y+pHv1lG23VFvx0E3X5tSwW/PyZHAM5msJhlB5THDNuGcV2M0COKc
         LPkEhVH4pj4wXresq8Fj8lJdjZHV4r1JjTk5sDqV7bZzkrxxbzn/yhid28YfHHngP4Hd
         H0GwW1jxCv2W6hD+H8xxCzXBo2bn9Js49mCBLlCR6grHpYLn1NesNNDCnoLg/cZxDHVo
         GF0YdNi5GjV7q53UemZHmH7UxMtYd5S36L0sNlwljXL2KiCpV+5qRifHQiYVEPmeX7HS
         EHEnWO1YxzOGXed4dJNIaATC5JmZ4sPmK70K/i5+UC4ydGkyv+Edt2Enq2FfOn6o2laV
         Dn3Q==
X-Gm-Message-State: AOJu0YxHX4o4R90GelkKsdHECspZepGICan2Ue/aRFULZCeXS4QotgtQ
	/k52TokmYhbE1YUZmNPYxnjVqQ==
X-Google-Smtp-Source: AGHT+IHWsp+cfB9xi7HfXzH6TBDYcA1Sv3F4kq9Lyt5FMc318rXqB8lIbQ2rOqVehb755XG/q1yIjg==
X-Received: by 2002:a05:6a21:3102:b0:18f:97c:ba21 with SMTP id yz2-20020a056a21310200b0018f097cba21mr2387789pzb.123.1701930713440;
        Wed, 06 Dec 2023 22:31:53 -0800 (PST)
Received: from smtpclient.apple ([103.172.41.205])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902b68700b001ca86a9caccsm521331pls.228.2023.12.06.22.31.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2023 22:31:53 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
From: Li Feng <fengli@smartx.com>
In-Reply-To: <CACGkMEt4_T5-aArkS4LOQsndwrMkjm_K-uPjdFnNRvwknQPaPg@mail.gmail.com>
Date: Thu, 7 Dec 2023 14:32:43 +0800
Cc: Jens Axboe <axboe@kernel.dk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ABA117F8-58AA-40EC-B3DA-4AB000A72BAD@smartx.com>
References: <20231207043118.118158-1-fengli@smartx.com>
 <CACGkMEt4_T5-aArkS4LOQsndwrMkjm_K-uPjdFnNRvwknQPaPg@mail.gmail.com>
To: Jason Wang <jasowang@redhat.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)
X-Spam-Level: **



> On Dec 7, 2023, at 14:02, Jason Wang <jasowang@redhat.com> wrote:
>=20
> On Thu, Dec 7, 2023 at 12:33=E2=80=AFPM Li Feng <fengli@smartx.com> =
wrote:
>>=20
>> virtio-blk is generally used in cloud computing scenarios, where the
>> performance of virtual disks is very important. The mq-deadline =
scheduler
>> has a big performance drop compared to none with single queue.
>=20
> At least you can choose the scheduler based on if mq is supported or =
not?
>=20
> Thanks
>=20
The "none" scheduler has better performance regardless of whether it is
a single queue or multiple queues. Why not set the single queue =
scheduler
to none by default?

Thanks.


