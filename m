Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC4636B05C;
	Wed, 18 Mar 2026 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773819876; cv=none; b=cwHYxwfKk/qSYJlxbtCqlnx2UzMwGxPa0ak5R88TA1Jn82QICKHzPWYwxTIRIecwrroSo5O/ouBDYmaK9+a/DmGCFRrVXY1imLQw/fbrPMFx7T8a+SkGASnCiZ1IaInHN2LF8/GtlsGnTg7RcjbCFJ9+t/BLwuM8brFENPXT2r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773819876; c=relaxed/simple;
	bh=pfl4/WDpx8izy7SlRiV79s2xx74aCZOZmuIycI4c+OE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=shZ/+PPOAOLiNhXVRj0tLaEWPAeXgTWPsuPkPA1/1ZCIBsLgMzA7DHMZ4rDIFKX5GQw/GGw0O1McwIv38LPYsqPnwHW3i8xcD7N+vsBdnetlwPnbDskmXZOlKs/Agn5yQwNz3lRdv+uvoLJ5S5E2dWUFEzRjDfhmuG6M8sIhX7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLvHErby; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLvHErby"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB73C19421;
	Wed, 18 Mar 2026 07:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773819876;
	bh=pfl4/WDpx8izy7SlRiV79s2xx74aCZOZmuIycI4c+OE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=mLvHErbyVCXFzG6bG9x2SDmt7FjGyJpbAwutl6fgBWRdLTMh0IJnONCQDEbxOinSl
	 H4VDY8SZlVSfzOlzttZQFgbqMa95w8LXKbAuXW1naLH/vUDnvsJqYWOnGGf+leG4x8
	 oI31HrkOrf6mJhUsRvrFJig9bpjxuixrRVYMe2IK9RjNX565C41fCbuR5/0YhN+zUE
	 Y/Tt9GFvHcsStAoJl1drdDKRZIA22ySnk5HIBymsg4Oi43cGWCcvoKnU2lvHO/R/lU
	 PUIBN63ORef7n2ZbJlIGm0BItFD2eKkKqW8Fc/4IMOm1//+cMjyeSjBPb4eFkJTHoS
	 r5tlvZ+K6FluQ==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 08:44:32 +0100
Message-Id: <DH5QNZZ3SVKE.QX0JBZ2AVQEO@kernel.org>
Subject: Re: [PATCH v4] rust: block: rnull: update to Pin<KBox<QueueData>>
 for PinInit
From: "Benno Lossin" <lossin@kernel.org>
To: =?utf-8?q?Adri=C3=A1n_Garc=C3=ADa_Casado?=
 <adriangarciacasado42@gmail.com>, "Andreas Hindborg"
 <a.hindborg@kernel.org>, "Jens Axboe" <axboe@kernel.dk>
Cc: "Boqun Feng" <boqun@kernel.org>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>, <rust-for-linux@vger.kernel.org>,
 <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260317193257.13848-1-adriangarciacasado42@gmail.com>
In-Reply-To: <20260317193257.13848-1-adriangarciacasado42@gmail.com>

On Tue Mar 17, 2026 at 8:32 PM CET, Adri=C3=A1n Garc=C3=ADa Casado wrote:
> Utilize the pin_init! macro for QueueData initialization to correctly sup=
port in-place initialization patterns. This aligns the driver with standard=
 Rust-for-Linux pinning practices for driver-specific queue data.
>
> Signed-off-by: Adri=C3=A1n Garc=C3=ADa Casado <adriangarciacasado42@gmail=
.com>

You haven't replied to Miguel's questions and disregarded his advice to
wait for maintainers to get back to you before sending a new version.

The patch itself is completely unnecessary, there is no need for pinning
for `QueueData` proven by the fact that the code works as is. Please
reply with an email explaining your thought process and don't send
another version.

Cheers,
Benno

> ---
>  drivers/block/rnull/rnull.rs | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
> index 0ca8715fe..11ea0696d 100644
> --- a/drivers/block/rnull/rnull.rs
> +++ b/drivers/block/rnull/rnull.rs
> @@ -54,7 +54,7 @@ fn new(
>      ) -> Result<GenDisk<Self>> {
>          let tagset =3D Arc::pin_init(TagSet::new(1, 256, 1), GFP_KERNEL)=
?;
> =20
> -        let queue_data =3D Box::new(QueueData { irq_mode }, GFP_KERNEL)?=
;
> +        let queue_data =3D Box::pin_init(pin_init!(QueueData { irq_mode =
}), GFP_KERNEL)?;
> =20
>          gen_disk::GenDiskBuilder::new()
>              .capacity_sectors(capacity_mib << (20 - block::SECTOR_SHIFT)=
)
> @@ -65,16 +65,21 @@ fn new(
>      }
>  }
> =20
> +#[pin_data]
>  struct QueueData {
>      irq_mode: IRQMode,
>  }
> =20
>  #[vtable]
>  impl Operations for NullBlkDevice {
> -    type QueueData =3D KBox<QueueData>;
> +    type QueueData =3D Pin<KBox<QueueData>>;
> =20
>      #[inline(always)]
> -    fn queue_rq(queue_data: &QueueData, rq: ARef<mq::Request<Self>>, _is=
_last: bool) -> Result {
> +    fn queue_rq(
> +        queue_data: Pin<&QueueData>,
> +        rq: ARef<mq::Request<Self>>,
> +        _is_last: bool,
> +    ) -> Result {
>          match queue_data.irq_mode {
>              IRQMode::None =3D> mq::Request::end_ok(rq)
>                  .map_err(|_e| kernel::error::code::EIO)
> @@ -87,7 +92,7 @@ fn queue_rq(queue_data: &QueueData, rq: ARef<mq::Reques=
t<Self>>, _is_last: bool)
>          Ok(())
>      }
> =20
> -    fn commit_rqs(_queue_data: &QueueData) {}
> +    fn commit_rqs(_queue_data: Pin<&QueueData>) {}
> =20
>      fn complete(rq: ARef<mq::Request<Self>>) {
>          mq::Request::end_ok(rq)

