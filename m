Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V2irPddQ"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [IPv6:2001:41d0:203:375::aa])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7701EFA;
	Thu,  7 Dec 2023 03:22:35 -0800 (PST)
Message-ID: <7066a459-33d7-42e1-a493-d6c89fe5c5b9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701948151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cb4VzxVK91eLXSAhmzzWZfAL/A/PEiW5e8jadap0ozw=;
	b=V2irPddQriH6vWR3AaSXIKqHFuVR6AykAkBM6sgAkLtyapy8RJsff6x8Gx2CvkjWXaov/d
	/attKbJ5cxqVpDBgEM7RHnJRG4BXhZfBhEt2nC7ZbuPFDzDSNKXXvo+wbjV7L46k6BycD+
	3pI2EhCpxXHGhgFT466NesVk+c04AM4=
Date: Thu, 7 Dec 2023 12:22:29 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 02/11] block: Block Device Filtering Mechanism
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, corbet@lwn.net, snitzer@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, viro@zeniv.linux.org.uk,
 brauner@kernel.org, linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Sergei Shtepa <sergei.shtepa@veeam.com>, Donald Buczek
 <buczek@molgen.mpg.de>, Fabio Fantoni <fantonifabio@tiscali.it>
References: <20231124165933.27580-1-sergei.shtepa@linux.dev>
 <20231124165933.27580-3-sergei.shtepa@linux.dev>
 <ZXF33Q9TpF4kBXP0@infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sergei Shtepa <sergei.shtepa@linux.dev>
In-Reply-To: <ZXF33Q9TpF4kBXP0@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


Hi Christoph.

Thanks for the review this patch set.
You've given me a good deal to think about.
