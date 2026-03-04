Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0023382F3E
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 20:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772657739; cv=none; b=X8rgIXv7Vq5scw/WVdT5vjJYifVDZvHLbw7sc3Toj+Kgg3WNCxnUXYlOnk/NGyflfhwdID4Q/KUeuIvowRVwRzEsEAuNJFDpHlgqF1bNjRXxRIqh0Q0r6dmUZ47jPmStXiXVY+brf1jJRm/6GdNujrDIGah5T4qryYFffe6A9vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772657739; c=relaxed/simple;
	bh=0qblyR13w8QN/AEFEFAPiPJzMM10aeL3k9TzPCV1raM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sceTObACq3XCb3Am+/3h3Q7OZC4q+vQwk3TxmAXf3U5I6K2+mdPXbqPQL5AgSK3GQer0jMdrIthzCTIFGmRG1uU9vZcNzpFZSaQizO7uq4eK0bjqD5crSAoiUh4ibmQ/UUQhV433CBKOEyXaqJm7vaH8cazp0Dtys3BwENK+tqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=RS9inGAa; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="RS9inGAa"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fR4gr2d13z1XM0p0;
	Wed,  4 Mar 2026 20:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1772657731; x=1775249732; bh=gpE24x2BytiF5A693tgI7Di2
	wHOqU0AYjdC8NRtqf/Y=; b=RS9inGAaHvKiSV16yftFtljmF0bC/B4Doro5+I6e
	AmR0GBv6bbIySwXIHYmznfCOJ3LB9Sa7LxQLOmzojll1CRqSgMfGWChXbLxsVb2F
	rhARzw/r7dTAUxGw2J3zUXyoVOyaMCUBgTpZ0oK4yNJSMSUKbtHGu2o86R22q7Vd
	J/xdtHMSgAf2boM7sUZPRf7rxOp58G0jsMEhkuKuzvnXFFIkAhgmxl78o0YttZdj
	ZMoRAuij0Vi2QhGtik7xjwnZj14QIFlAe6dKXH8K4PMMBjMfHfVe7dtoG6Naz8j9
	BfLb2azTVNUtdY1f+CxZ9NoTQ2CM/InNUhEVU/nsEnLL4Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ytiy1nZckoHk; Wed,  4 Mar 2026 20:55:31 +0000 (UTC)
Received: from [192.168.132.187] (unknown [12.150.89.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fR4gh71HDz1XM5kt;
	Wed,  4 Mar 2026 20:55:28 +0000 (UTC)
Message-ID: <c658a073-ec42-40df-a03e-c34cb5c3f545@acm.org>
Date: Wed, 4 Mar 2026 14:55:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] ublk: Fix the lock context annotations
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
 linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
 Nathan Chancellor <nathan@kernel.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
 <20260304194843.760669-12-bvanassche@acm.org>
 <CADUfDZon_tUuZzH3we4NdPg_MB-LQsMWbeRrLAiqzBbSM9hG-g@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CADUfDZon_tUuZzH3we4NdPg_MB-LQsMWbeRrLAiqzBbSM9hG-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 3/4/26 2:43 PM, Caleb Sander Mateos wrote:
> On Wed, Mar 4, 2026 at 11:50=E2=80=AFAM Bart Van Assche <bvanassche@acm=
.org> wrote:
>>   /* device can only be started after all IOs are ready */
>>   static void ublk_mark_io_ready(struct ublk_device *ub, u16 q_id)
>> -       __must_hold(&ub->mutex)
>=20
> I don't think this is right. Both callers of ublk_mark_io_ready() hold
> the mutex: ublk_fetch() acquires it directly, and ublk_batch_prep_io()
> is called with it having been acquired in
> ublk_handle_batch_prep_cmd(). The stores to ub->unprivileged_daemons
> and ub->nr_queue_ready would be data races if the mutex weren't held.

Does this patch look better to you?

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 34ed4f6a02ef..26c368e5358b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -353,11 +353,13 @@ static inline bool ublk_support_batch_io(const=20
struct ublk_queue *ubq)
  }

  static inline void ublk_io_lock(struct ublk_io *io)
+       __acquires(&io->lock)
  {
         spin_lock(&io->lock);
  }

  static inline void ublk_io_unlock(struct ublk_io *io)
+       __releases(&io->lock)
  {
         spin_unlock(&io->lock);
  }
@@ -3160,6 +3162,7 @@ static int ublk_check_fetch_buf(const struct=20
ublk_device *ub, __u64 buf_addr)

  static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *u=
b,
                         struct ublk_io *io, u16 q_id)
+       __must_hold(&ub->mutex)
  {
         /* UBLK_IO_FETCH_REQ is only allowed before dev is setup */
         if (ublk_dev_ready(ub))
@@ -3581,6 +3584,7 @@ static void ublk_batch_revert_prep_cmd(struct=20
ublk_batch_io_iter *iter,
  static int ublk_batch_prep_io(struct ublk_queue *ubq,
                               const struct ublk_batch_io_data *data,
                               const struct ublk_elem_header *elem)
+       __must_hold(&data->ub->mutex)
  {
         struct ublk_io *io =3D &ubq->ios[elem->tag];
         const struct ublk_batch_io *uc =3D &data->header;

Thanks,

Bart.
