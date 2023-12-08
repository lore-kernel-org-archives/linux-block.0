Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVfgRTVE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE3E123
	for <linux-block@vger.kernel.org>; Fri,  8 Dec 2023 03:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702033668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZ68z0Zmw8ZgsbDmEzD6URQldfv+XNMK6DMNEIcDVTU=;
	b=VVfgRTVEmjt5/W/rfuPGjVr0mhe+P+K3ZvtHwgTbd0BbvJV8+K+ggLoPJaff4DLpyp/ull
	z9HkWV46iV1trBZs3Igf2U58SBRe4ZwW0ZrY49Rr2Nzx/9VfJqBLjS2SzAF8MdpP8UrKxy
	kdWCrpAM9xrN0aiurngFb8RBsJawtCA=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-SJ9HoDApP9GmpZT6iDQIOA-1; Fri, 08 Dec 2023 06:07:47 -0500
X-MC-Unique: SJ9HoDApP9GmpZT6iDQIOA-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4b02c393e25so533627e0c.3
        for <linux-block@vger.kernel.org>; Fri, 08 Dec 2023 03:07:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702033666; x=1702638466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZ68z0Zmw8ZgsbDmEzD6URQldfv+XNMK6DMNEIcDVTU=;
        b=ItkR7K0B7U7DrDanQTxBSaQAuc08TQAQXGIVxvqOBsO4D7J32uqUn+Nxv8L2CZ6hsE
         /AuBMXQwACy2DiaSgds/Hmkd4/DpDRUQ/ge9IqrAnLopMq+uL96Vo/yyHZx1QhXHlx7u
         xtBp4j9c6b8nos2QDa8wvUmN+RVHICdchKHvJoC/pNxjIl70ajzgndMtDh7QzpW//T/a
         TJ7IXIDNIUPEahOQieqeHON5XWah0kOSI5kvoGIQPgz8sSfmrNhpPB0IJYOyTZLloYwd
         QO9hB0X9AT3zvuRdPRIdPD+7nzQiUHM0Semyw/bWq8k/kxBI231l2FZuJOqf529HilQ5
         8rDQ==
X-Gm-Message-State: AOJu0YyPwMjqkek+wVna4ujyXGcmTyHTFcbvy+Yufrt4wkNfJSCp1R1z
	E4P5WmC2SRMO1ACFOPgByc8Y+CyL2+MqD41l2eHCUBS3/WRZLdv6uqEuhgrBrf0cZkq1cd0DxZY
	U8pe3QCV6tKVnmNTg4LBr82Hf0Bp24TKp7ZJH2fc=
X-Received: by 2002:a05:6122:2a49:b0:4b2:891e:225a with SMTP id fx9-20020a0561222a4900b004b2891e225amr5351330vkb.11.1702033666417;
        Fri, 08 Dec 2023 03:07:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrUEvJUaFrYyr5PGOydD15wueB/vwO/OYhbev5UD7asruhM4Q4Ek5B68h+qhR0sIfIIlM2RUFm2TU+UMtSssA=
X-Received: by 2002:a05:6122:2a49:b0:4b2:891e:225a with SMTP id
 fx9-20020a0561222a4900b004b2891e225amr5351317vkb.11.1702033666140; Fri, 08
 Dec 2023 03:07:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207043118.118158-1-fengli@smartx.com> <ZXJ4xNawrSRem2qe@fedora>
 <ZXKDFdzXN4xQAuBm@kbusch-mbp> <ZXKTW7z3UH1kPvod@fedora> <6CB024E3-337C-41F9-9DA1-B54B6E19F78E@smartx.com>
In-Reply-To: <6CB024E3-337C-41F9-9DA1-B54B6E19F78E@smartx.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 8 Dec 2023 12:07:33 +0100
Message-ID: <CABgObfatL_NaPxU4RmmGsx9rz=8EVkpro=7Tpw_nLjKguzMDUQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
To: Li Feng <fengli@smartx.com>
Cc: Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	"open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 6:54=E2=80=AFAM Li Feng <fengli@smartx.com> wrote:
>
>
> Hi,
>
> I have ran all io pattern on my another host.
> Notes:
> q1 means fio iodepth =3D 1
> j1 means fio num jobs =3D 1
>
> VCPU =3D 4, VMEM =3D 2GiB, fio using directio.
>
> The results of most jobs are better than the deadline, and some are lower=
 than the deadline=E3=80=82

I think this analysis is a bit simplistic. In particular:

For low queue depth improvements are relatively small but we also have
the worst cases:

4k-randread-q1-j1      |    12325  |     13356  |   8.37%
256k-randread-q1-j1    |     1865  |      1883  |   0.97%
4k-randwrite-q1-j1     |     9923  |     10163  |   2.42%
256k-randwrite-q1-j1   |     2762  |      2833  |   2.57%
4k-read-q1-j1          |    21499  |     22223  |   3.37%
256k-read-q1-j1        |     1919  |      1951  |   1.67%
4k-write-q1-j1         |    10120  |     10262  |   1.40%
256k-write-q1-j1       |     2779  |      2744  |  -1.26%
4k-randread-q1-j2      |    24238  |     25478  |   5.12%
256k-randread-q1-j2    |     3656  |      3649  |  -0.19%
4k-randwrite-q1-j2     |    17096  |     18112  |   5.94%
256k-randwrite-q1-j2   |     5188  |      4914  |  -5.28%
4k-read-q1-j2          |    36890  |     31768  | -13.88%
256k-read-q1-j2        |     3708  |      4028  |   8.63%
4k-write-q1-j2         |    17786  |     18519  |   4.12%
256k-write-q1-j2       |     4756  |      5035  |   5.87%

(I ran a paired t-test and it confirms that the improvements overall
are not statistically significant).

Small, high queue depth I/O is where the improvements are definitely
significant, but even then the scheduler seems to help in the j2 case:

4k-randread-q128-j1    |   204739  |    319066  |  55.84%
4k-randwrite-q128-j1   |   137400  |    152081  |  10.68%
4k-read-q128-j1        |   158806  |    345269  | 117.42%
4k-write-q128-j1       |    47576  |    209236  | 339.79%
4k-randread-q128-j2    |   390090  |    577300  |  47.99%
4k-randwrite-q128-j2   |   143373  |    140560  |  -1.96%
4k-read-q128-j2        |   399500  |    409857  |   2.59%
4k-write-q128-j2       |   175756  |    159109  |  -9.47%

At higher sizes, even high queue depth results have high variability.
There are clear improvements for sequential reads, but not so much for
everything else:

256k-randread-q128-j1  |    24257  |     22851  |  -5.80%
256k-randwrite-q128-j1 |     9353  |      9233  |  -1.28%
256k-read-q128-j1      |    18918  |     23710  |  25.33%
256k-write-q128-j1     |     9199  |      9337  |   1.50%
256k-randread-q128-j2  |    21992  |     23437  |   6.57%
256k-randwrite-q128-j2 |     9423  |      9314  |  -1.16%
256k-read-q128-j2      |    19360  |     21467  |  10.88%
256k-write-q128-j2     |     9292  |      9293  |   0.01%

I would focus on small I/O with varying queue depths, to understand at
which point the performance starts to improve; queue depth of 128 may
not be representative of common usage, especially high queue depth
*sequential* access which is where the biggest effects are visibie.
Maybe you can look at improvements in the scheduler instead?

Paolo

