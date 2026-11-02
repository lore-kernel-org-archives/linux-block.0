Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624383;
	b=VL5FPRY/lRXbrIzbBUsR3fUnafV4Qxr/gOuwsajJCFPNIbZSK3xQ46+g20JSxH+vPNgX
	 1xS0L3fwzOUskvbKrlkgEOt6nCazAuXiAHA+LMK6PvU57EfYSB+u4Rsm5TUbcEIBCWpf5
	 1S7JvngQA47JOub+Lhy4lvzgCD5MMAIRSK91It8Abg6UyCn9hAY9AZplw5WAnC9CPcXce
	 6w0+KhA0sF5iUThwka+msqhkZ8ZSRNR4LgHKLcQrE62DCg+3jU7cYaAx84e//2WXhfT4j
	 amY67Xo+4X9MCtV6/BC3xSVicZ1MUB/krbRglH7dJPYN8/vSR+vt+tbWflJqF3WXWUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624383;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0QU938YZmI+90ta4rBgGtrqwO0xO5MqL3TKangYRrrc=;
	b=eb0hYigcl8swLhZNwbtN25vlA/TbIzkHhZUQ0dLYb3nhizHpFyRDkQwRYdiQe4HCd+NC
	 fPCq1qvOdH5n1aZiLK+va/k3T46yCqn43kAwJjQ+b0lGGJTvZA5HCLNPyMJAEobg9LgMv
	 z6I4KW85JVnKyTJppAGMCL4cXVgcuorH3mYYWlKVGAWKJI00x2k+6I7wrdljL4fe7xP0M
	 pFZjcEgbR5wiqOi3oxnKno5wFaaljUVUD17eTYIVydcbWF2gtNXxYoAkeCWvgSVAO8I2m
	 wTZd+kMZBhva0UiBgPr5fNsL5AsUXE/Nb8gk22hfTGNRWJeBskopqn99d4/xcKcUfww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BjDejfpt;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BRdkBEoO;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A114606A329
	for <linux-block@vger.kernel.org>; Mon,  2 Nov 2026 12:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A114606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BjDejfpt;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BRdkBEoO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793624379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0QU938YZmI+90ta4rBgGtrqwO0xO5MqL3TKangYRrrc=;
	b=BjDejfptVFHF7RlmBekort2+3mQBsp4XNpAnGDgDVkZqsRWQazzzrpfFpTYWCLGTK6y7Ci
	eueeUT1vWR3Wh1dQX7ngtJGmw+4Yw3RRNKxmMA8WY/SlYOBbFBv5g2UxQTWhwwyNY+a3Cc
	k8n0/S4ZEPVD7FlM6MzBL082aw0imhE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-bzomXy9_NwSzra6PJHPsTg-1; Mon, 02 Nov 2026 07:59:36 -0500
X-MC-Unique: bzomXy9_NwSzra6PJHPsTg-1
X-Mimecast-MFC-AGG-ID: bzomXy9_NwSzra6PJHPsTg_1793624374
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e00f3929bso2475716f8f.0
        for <linux-block@vger.kernel.org>; Mon, 02 Nov 2026 04:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793624374; x=1794229174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0QU938YZmI+90ta4rBgGtrqwO0xO5MqL3TKangYRrrc=;
        b=BRdkBEoOnpUpyCXr2py9edkl8wcICrj5cvMtlj96Wlalrso9ci4qYS45Srfn+QiSXL
         u6jtW6sJGjXBLUZCwu0nAGwhCgJMi0i0ybPpdz5CbpnNDixxinChR6uFPcJotn2DZFin
         UwxXIF1wX6GKBvFG9oS+uMwcd7fVsFiMu0MxDiENApZUi0gsI8ovsmq9Ndy/iqAUb7W7
         1UjNTtbD6m+wiXT+I4Zwkxg59rFsg4/meszFajCIklqBT0l46Y3fIyiWAeSTVkVrrZ6w
         C9qLFzfrPRutjDrmm76C1+GlY3UtixDIUPPe7YwpiqngB5JUI5ld2REuh5eztViFfkCx
         HIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793624374; x=1794229174;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0QU938YZmI+90ta4rBgGtrqwO0xO5MqL3TKangYRrrc=;
        b=ZsK/8sp5PIV9p0bt54HMKDUU4B+TYzfnZuTApgGIzIpOY13Vvb26VAPV8tZlCwEe+X
         j1WH/RlBUWo0rB3abfDW+ct4QQ6WP7AfFT2g8dEOyWK6nX8NGjshBPPb1CTGDHvziSJp
         AMFkezI6i9vzbVp5KYY0pkQPRbKcunb/ZflVsSa3fE72c0CtSEHu8N9AbrScgK2tWsM0
         JTeVLQdCSlui6ROdLo81oFdBy43VYfF3ATsyTfm38YI0PTYAwYzjJ2mlYX0I7EKYbv0D
         ZFYP7IX4TdhtHKS1RJRks73n/SIyqAt+9n9v4QX8+jNFvLCXEShkTIFnkpiARWaI5Wlt
         nJbA==
X-Forwarded-Encrypted: i=1; AKwUvBwkyOfLpczZQsrq4qsfF7cEP4GllTZK//GM7yUgd3b7wdNY97eLoGR0i+qWSHfBZQv3+CqQo3Wdlxhn2A==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Nygprskw5q4M4xZuWf1BxUWjqveP1Fdo6xPTpjsPkEOcCKcNZ
	0yOIKzaVQIYfgRMBUER2EgMG3X4GHJsDLnCywFXyV59AvOOQvRoJse8f8YlGIyYo02/bwyBbeRw
	hoW5j88XlYpFPsclLIcoQp7+Afb2eusd+Qr7l8XQ94P5++CrQ3iLKkIMN+S0atHr8E77lagTb
X-Gm-Gg: AYBFou3SpFS2tilWa3FaYGR+5ovPB7dQbdwsBKAoYv8svK3OcMcWrMihlqmM1RxzbNT
	DgCjYVMwSp4zq9ZOUeXZSL26sVdx7uIeUo7G2RTtChsv53NWMVLF4Ec18gyHKrImWohtP+L0Ty9
	m8E7P8iUU0gtGkdVgcfVHDIom/36XSVJkQHDA2R2tzvkx7SaRnHDeHci8q7yaEdG0JL55psdWm7
	wykXWfjNA7iHbuRSbDWMgAecQn+RzocB/SWA1Bw6e7vgkbfDsLFMk57JrDfvLVcWSCYN7yKgyNH
	vIaOb43hhQI0XBcHAu1wcclJyPQBIinSsjIgskbukl3dBNtcbfmBgdTbjAHRsUTMA7qSk7lJiwH
	VfeQ910alSMQlIJxQ+rtVyofETmNNq8jILd2RcK0RdA==
X-Received: by 2002:a05:6000:4010:b0:48e:55bd:9cdf with SMTP id ffacd0b85a97d-48e6e2dd3a4mr25444612f8f.21.1793624373982;
        Mon, 02 Nov 2026 04:59:33 -0800 (PST)
X-Received: by 2002:a05:6000:4010:b0:48e:55bd:9cdf with SMTP id ffacd0b85a97d-48e6e2dd3a4mr25444547f8f.21.1793624373259;
        Mon, 02 Nov 2026 04:59:33 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1501:b100:9ea2:fd21:b361:8dab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b7270asm20090543f8f.11.2026.11.02.04.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:59:32 -0800 (PST)
Date: Mon, 2 Nov 2026 07:59:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stjepan Poljak <stjepan.poljak@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] virtio_blk: fit requests to virtqueues without
 indirect descriptors
Message-ID: <20261102075830-mutt-send-email-mst@kernel.org>
References: <20261101165307.2557421-1-stjepan.poljak@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101165307.2557421-1-stjepan.poljak@gmail.com>

On Sun, Nov 01, 2026 at 05:53:05PM +0100, Stjepan Poljak wrote:
> A virtio-blk device without VIRTIO_RING_F_INDIRECT_DESC needs one ring
> descriptor per segment of a request, plus one for the header and one for
> the status. virtio_blk takes max_segments from the device's seg_max
> without checking that against the size of the virtqueues, so a device
> that offers a seg_max above its queue size minus two gets requests that
> can never be added to the ring. virtqueue_add_split() warns, returns
> -ENOSPC, and the request waits for ring space forever. A virtqueue with
> fewer than three descriptors cannot hold any request, and depending on
> the queue depth the probe then either fails without saying why or hangs
> on the first I/O.


Thanks, I applied
    Message-ID: <20260918135120.1261150-1-sergiiushakov@google.com>
to fix this, as it seemed like a more comprehensive fix.



> I ran into this while writing the virtio-blk device of Hearth, a small
> KVM-based VMM, with queue sizes and seg_max values like these:
> 
>   virtqueue  seg_max  queue_depth  before                    after
>   ---------  -------  -----------  ------------------------  -------------------
>   128        126      default      boots                     boots
>   128        127      default      WARN, hangs loading init  boots, 126 segments
>   128        254      default      WARN, hangs loading init  boots, 126 segments
>   1          -        default      -EINVAL, no reason given  -EINVAL, message
>   1          -        128          WARN, hangs on first I/O  -EINVAL, message
> 
> where the message is "virtqueue size 1 is too small for a request". A
> virtqueue of 2 is rejected the same way, with either queue depth.
> 
> Patch 1 checks the virtqueue sizes in virtblk_probe(), before the queue
> depth is derived from them, and fails the probe with a reason when one
> is too small for a request, whatever the queue depth: the last two rows
> and the virtqueue of 2. Patch 2 then clamps max_segments to the smallest
> virtqueue minus two when indirect descriptors are not negotiated: the
> seg_max rows.
> 
> The seg_max case also reproduces with QEMU, which with seg-max-adjust=off
> offers seg_max 126 whatever the queue size:
> 
>   -device virtio-blk-pci,drive=d0,indirect_desc=off,queue-size=64,seg-max-adjust=off
> 
> Before the series this warns and hangs loading init, after it the guest
> boots with 62 segments. With QEMU's defaults nothing changes.
> 
> The seg_max cases were tested by booting a busybox guest that reads its
> disk with O_DIRECT in 1 MiB blocks, the others by looking at the probe
> messages, on v7.3-19954-gcbbddb6b08cc, x86_64.
> 
> These patches were written with the help of an AI assistant, as the
> Assisted-by tags say. I reviewed and tested them, and I can answer for
> every line.
> 
> Stjepan Poljak (2):
>   virtio_blk: fail the probe when a virtqueue is too small for a request
>   virtio_blk: fit max_segments to the virtqueue without indirect
>     descriptors
> 
>  drivers/block/virtio_blk.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> -- 
> 2.53.0

