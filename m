Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022C227FD6D;
	Tue,  3 Feb 2026 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142267; cv=none; b=tOhYNcfet5c3vaRkX7Vk11pkoUq8Ssk0qN5dy9ZaM9pADXzxtyCDiZNN3Lkd+o+49TWdxGz81GonwI63LV7hje4BM+h4ItL3XscfSzbu/T5OmkUuu7oTo0Bv9qPebP4YqWz+p5z/trP+45RhrLrNmku0FCb2S+8vtZ6O1+FCiQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142267; c=relaxed/simple;
	bh=X4qaHjFRIDiCbiijmjrj2V9sL/nMIfkCZfKs0c1cB2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SbBdAmo8wlJCNtsb6wFpdygR7hjd1bs6/5E5pL0yGSZMW20GNDUVNKOR+6oYylEdkDQljqFHHgW3EEzRjK8wbrKfJSut+bQW0/jec/uT+nRORRR3jFv2yn7NGgs/v4ybpOeNobLWYfHU4MHUzvaPLJV7uGhjrD6uF4bFVJGiRro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=gYfVC6/j; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="gYfVC6/j"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4f5BPH37CYzlfgfB;
	Tue,  3 Feb 2026 18:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1770142257; x=1772734258; bh=X4qaHjFRIDiCbiijmjrj2V9s
	L/nMIfkCZfKs0c1cB2M=; b=gYfVC6/j4ypsXHIgVcugwzL3FiY2kq7YnZ9ys2NR
	zfdLEJQ6fUYEyRY0EPqVvKOqNA9fCe5fewjo2avy9VaMYJptqXZI66hy7NG0xtQA
	w/i82TvilAHAOuubMViv00BLP8Gbg9DpsShiBpV6YA1HBcov5WD8j5Fk4QqC0qgp
	bm4NjDiiZ/RX9FGclk0/LIK9ALv72gyF8QQ3qAOKwaHFLxSzGm5xLv7kBTFCySRt
	JQJztJQ3YNhOXSlLUSwO1Wi15TsBCJAtR5i6nAUy0RnhW2NKRmerr/8XiF7ML6t/
	kBXZ/3uZgacchNLa4Li8a+W8On2c6a24F5/ozbVdZggSng==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cd7CaZhGwjLJ; Tue,  3 Feb 2026 18:10:57 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4f5BPD1SGwzlfgf6;
	Tue,  3 Feb 2026 18:10:55 +0000 (UTC)
Message-ID: <2d3b720c-5637-45e7-887d-077b1e9b3c23@acm.org>
Date: Tue, 3 Feb 2026 10:10:55 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] - Short freezes in gameplay due to MMC_CAP_AGGRESSIVE_PM on
 RTS525A card reader
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Ricky WU <ricky_wu@realtek.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 linux-block <linux-block@vger.kernel.org>
References: <ff9a7c20-f465-4afa-bf29-708d4a52974a@linux.dev>
 <CAPDyKFrGpvjONrDmnNZXv+SME_NCNv-LK8J-Vo88RSz1fuD7rg@mail.gmail.com>
 <787171c6-0b9c-400b-8a95-b331b58e284c@linux.dev>
 <4777aabd-bc9e-4904-9444-892393aecb15@linux.dev>
 <9e362d5fa2604fb0848ea28866dc45fc@realtek.com>
 <47ed09fc-047b-4f98-8df3-d11d17678c57@linux.dev>
 <380f75c7adc04cbab38cfd2f82bd0c6d@realtek.com>
 <d46dcebe-ca58-44c4-87ee-cade2e478572@linux.dev>
 <4205fde06ecd4a7489b03ef25e5e4011@realtek.com>
 <CAPDyKFoC-dwzcsABNy9pA=GGirBWwcxQhNMeTSSStXHtXmWbcg@mail.gmail.com>
 <0b6fd99b-54a6-45f1-942e-94f707f2fbf5@acm.org>
 <CAPDyKFqic-rFe95g657MdZHtdPXTmFmYQG4ZSBV56S3DhMEF-A@mail.gmail.com>
 <dc1ac2e5-1db1-49b5-847d-a10a611027ae@acm.org>
 <CAPDyKFrNHc4FexuTbdWM-Kvo0mn9C51nJN5b=e0jZR8miFho+g@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAPDyKFrNHc4FexuTbdWM-Kvo0mn9C51nJN5b=e0jZR8miFho+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/3/26 3:28 AM, Ulf Hansson wrote:
> I guess the question then is, do we always want zero latency, which I
> assume must be costly from a power savings point of view. At least
> during the idle period, while not serving I/O and waiting for the
> device to be runtime suspended.

Block I/O latency suffers if a CPU core enters a lower power state while
waiting for an I/O completion. Hence the choice in the UFS driver for
not allowing CPU cores to enter a lower power state while any block I/O
is in progress.

Bart.
