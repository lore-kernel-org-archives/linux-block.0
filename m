Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931472641D4;
	Thu, 13 Mar 2025 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741859045; cv=none; b=e0ug+dH8baS367HiXmCFScM4jMzTiHNgQwCzgxsjaxuI+y0sbtm4RAqDWr7SQAtbfzYQ9uoMlORt595FlbioskfabVPZ0dpPplFOd7QF8TAGmSV+9NBMSIqn5cILNN0c5vBxRGtVYeWhcX7MPtkJEAdfZXGOgi0CfQy/XhhTE7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741859045; c=relaxed/simple;
	bh=EQzdggXH4wkl4AhZbwxv9KJH+Qe+YvgwV8nYRRuD+xw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQBj4mbEO0Tk+1cdZAVn6uVZ980pYLiK8DAVc0ca6ofl9Z2pIXgB64e9cVXSmuovRN51JOx4BSDJeN5q5uGGaoEIR1W+16IYI/uMROfh7IAr1lstfap9a56SVfQqV4aap2jeJiDNsVc5S5+nYsbIGqc8C8wER0K/8KxwWakE/e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOSrjDr7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOSrjDr7"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so5940375e9.2;
        Thu, 13 Mar 2025 02:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741859042; x=1742463842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUJmmUk/07zvVDebbkY7gqZx1aQN0BEIXNKF8zNXE08=;
        b=FOSrjDr7RuVvlCZbBUsNhQlwl4H+6LzHJgP9n87f5xLZdyK4sa9nhYrA7yfmv0P0Vw
         V2CzQZ2Md7GCYNw+6rSd56Cq7OndWu/bfDDTZrLDflKSJBRrS0A2E1b2ARNR1PlEpw90
         JLCEePyZs2WhLyoiOBKfyG9+Ke5Qcvt7CIitYhFdmDC1eq3+8OH5eOgqon+NPQAulbOR
         6jnza32Dz3EIUPZfoclwDMkWa1wn7KFg+9kJhinZvpejw0Jw40JLEbEj4mAIot3uUHk6
         +pYjfFIPTP8T/Li7zs6jJ8hIxvdPa0dsAfuXiTDUGVk50MOfZw/OenoYKM9MsTWHYLrB
         VbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741859042; x=1742463842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUJmmUk/07zvVDebbkY7gqZx1aQN0BEIXNKF8zNXE08=;
        b=sTxAH1UjhJ1XzbJabhO3HUl22YtzVpf5M91shSDQY4BPbbUOHtrvxOn5xu6hM/qQyK
         ESY9SK7FwhMmVmCUJm6LlIft9v5sKRwufiGyK/QeJnmc/skCiQGqpWVkczlZQOIvTTVP
         1mxIVfFs8dmVWYYOhHl58tWAmXtaaubAALyhllYv8ZdHiiuRcoK9elURJ/69XNJ8G3M5
         tE8ciLodGn6mTD8BR6rWEE1w817cx7M+hXr5NOpBiLCLXRmh8LyFKsSgKvxh2fO/xMDW
         iGacrgau6vJbpt8WefYFx2YqLI4cf2pKn59YwkL0GFhUBLn5hdyAR8Ic1vQu7E4sM1wu
         jTRg==
X-Forwarded-Encrypted: i=1; AJvYcCUYA6+0W546ExHSX9H+lwV7bBTaMColpywA6LX7RkbO6RZvl+u4oplfhpjx624iGXwmRmCrj14dk+lt3w==@vger.kernel.org, AJvYcCVeSv8LLBxKoaRHrdnJjuHMlgVUyVKvkr5LC0EXukLE75g9qmCMjlrNUQA5A2Eu44TlNnJ0SFDH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/KWW7AROrggYLF3EM8EbIjHJ0bsaB9N3D1OsiNYiAQDjXTVj/
	b9pOs291OFJPtQQDpYh97hikgok1cSQAik20+kJz/AlhNSOLCUCF
X-Gm-Gg: ASbGncsp5zc0saa+Xpo5KTqJOKF+tqBWzjTofzopRtKuIum7rbVCDKxIwk2izKytnVP
	jd9HXqyVemNJA06BLLalnLu7llVHFuEW03jgeSb9zNQTtaxslBAoYMeRimSprQnWykdUad4wAgh
	pr6nvr3L3fYvcSf4W6P4MehLvyU7l7SHM14mb2O/EXnVit21zCltrTW0xa8Pb7M4QwG1MSO8HZo
	KQtL+u4r0YY55XJx2Qe0B3X/QkumwpkSbSWKFU2L1Vw7m3ZFSnYsFS9p0gHyEjt6KrznMTxywjL
	GxGaohDOsQWI+I01wl7aDlsRA4OdfqVuUwyk5zA2lFEIQ+FLLpRzohWnRZSBIBC65VQ5OyCR0qe
	0OYsMKVU=
X-Google-Smtp-Source: AGHT+IEmmbcF0ODRKe4fmMsHDHsI7+wnGoFRrNeO5xpay+Qmm0MBcWmeFOZRVaD+g3RmvyNJTm7SgQ==
X-Received: by 2002:a05:600c:3791:b0:43c:ec28:d303 with SMTP id 5b1f17b1804b1-43cec28d49fmr174424815e9.5.1741859041417;
        Thu, 13 Mar 2025 02:44:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c4f9d59dsm1547427f8f.0.2025.03.13.02.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 02:44:00 -0700 (PDT)
Date: Thu, 13 Mar 2025 09:43:59 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Hannes Reinecke <hare@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Hannes
 Reinecke <hare@suse.com>, Boris Pismenny <borisp@nvidia.com>, John
 Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, linux-mm@kvack.org, Harry Yoo
 <harry.yoo@oracle.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Networking people smell funny and make poor life choices
Message-ID: <20250313094359.20756456@pumpkin>
In-Reply-To: <Z8iTzPRieLB7Ee-9@casper.infradead.org>
References: <db1a4681-1882-4e0a-b96f-a793e8fffb56@suse.cz>
	<Z8cm5bVJsbskj4kC@casper.infradead.org>
	<a4bbf5a7-c931-4e22-bb47-3783e4adcd23@suse.com>
	<Z8cv9VKka2KBnBKV@casper.infradead.org>
	<Z8dA8l1NR-xmFWyq@casper.infradead.org>
	<d9f4b78e-01d7-4d1d-8302-ed18d22754e4@suse.de>
	<27111897-0b36-4d8c-8be9-4f8bdbae88b7@suse.cz>
	<f53b1403-3afd-43ff-a784-bdd22e3d24f8@suse.com>
	<d6e65c4c-a575-4389-a801-2ba40e1d25e1@suse.cz>
	<7439cb2f-6a97-494b-aa10-e9bebb218b58@suse.de>
	<Z8iTzPRieLB7Ee-9@casper.infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 18:11:24 +0000
Matthew Wilcox <willy@infradead.org> wrote:


> What worries me is that nobody in networking has replied to this thread
> yet.  Do they not care?  Let's see if a subject line change will help
> with that.
> 

I like being smelly :-(
