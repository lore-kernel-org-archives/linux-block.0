Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA3F4C97
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728401017; cv=none; b=kE5J8ndjon2clZiH1N0aIp6IzIgCHf9qA0RqLgwHQZyewwIhTBw8Xbggr+FyHtSKzjvRwYGqZw6ZxhY111uG8yFfmJFqJk4bABTVgelYQ+LGd/cdCry4eP9z4R1Y2gL+VM/x5B1VLS6V4nVpglqjVka/zPIoIMcaO2F/W0a7e6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728401017; c=relaxed/simple;
	bh=no0ft86ZIRH05p/cHAmvC03LZtaaa8aJYqCDRHwuvdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHz9npz6OnVG95KmjfO0HfwGOs4FdM37XHireZjd4bq25xRuz7kcUmq4dolyuRiW+LWg/i7/aJTX7sjATIFwqouwz53qcmeeLyYewd2jb2SppRMJzG4JQW+USjd3ryZxUSRctZRB/W7FPS+NHxBRVmF67etcjj1U42t5R0BCgkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FqQTV6dd; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FqQTV6dd"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e221a7e7baso1950822a91.0
        for <linux-block@vger.kernel.org>; Tue, 08 Oct 2024 08:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728401015; x=1729005815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ok/VBy+V7sT6XIn/apworm3lRazIE74IkyeWk1rUaVQ=;
        b=FqQTV6ddAeptyQNjIHeezWPA0bxMbeZdKhjOg9ysO6IytSwqXT47dWeFZXYWT1amGy
         XHXxmS8ajw0ngp7e7VxGXeKwSzal+tHqu1CM99qyp5X9r5oQUvhhM4o+OMZnTscHcXki
         LFP94HbE3Nlm2KmguJzplTtXT9OZfDvq2a9hM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728401015; x=1729005815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ok/VBy+V7sT6XIn/apworm3lRazIE74IkyeWk1rUaVQ=;
        b=AQiwgIKPU/L8S8EtNwFBIace87MIuZLMQKj4BRuXM65dUOuy9mS0Qv/V7n/acRVPhJ
         B6WTGscYuTXWNs0WW5R14QxERtUHtqx2HWOWYJeT/a3oZdKZSVgWfnBd/TXUFZGucI2j
         oGdkeUfHurnyhEAIS/re5INygtR41Xmju4slanJq+0t9kwolLt68Vzlc42+aEfcbUU1v
         zl9MZZrz/DkQ1A0sVZFDQFe6NA4qzCK65gAKRXxNc5b1GQO7fW2LY1d86Kc5IqWs4cOG
         QFIVk2NKYNv6q2hnvr5bpxJvjPrFZgMTlLzNtVa2sQ3OQP/Xx0Fgp/rXU7MQTlQ/lL9N
         5IuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg46vPug6fGnYRTAgYAtbLBqfz7/g/oEq8yST+QWoQzIgWjXLYgGBMQP1OmeyZei18SBra0DoC9JliJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzRqSNfGVfBthxIdnbRzPbaTQCZ+AaXSilwlKXm7fsVzporazc
	D3nan4hcx+uyRCuJit4/u4G+dijt5iwByKOs8i8E7DZ7nQqH8VwY5M59Pf33DA==
X-Google-Smtp-Source: AGHT+IGWjX4teTRGoQE9b5AMhbxEJKM9YT1zUQGR6pDt/8OJVvux0M1wIumTIV/KLzhX41TS5iEozg==
X-Received: by 2002:a17:90a:71c4:b0:2e0:8733:6c78 with SMTP id 98e67ed59e1d1-2e1e62283d1mr17724219a91.15.1728401015477;
        Tue, 08 Oct 2024 08:23:35 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:7cab:8c3d:935:cbd2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e86a9400sm9455576a91.47.2024.10.08.08.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 08:23:35 -0700 (PDT)
Date: Wed, 9 Oct 2024 00:23:31 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org
Subject: Re: RFC: try to avoid del_gendisk vs passthrough from ->release
 deadlocks
Message-ID: <20241008152331.GA565009@google.com>
References: <20241008115756.355936-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008115756.355936-1-hch@lst.de>

On (24/10/08 13:57), Christoph Hellwig wrote:
> Hi all,
> 
> this is my attempted fix for the problem reported by Sergey in the
> "block: del_gendisk() vs blk_queue_enter() race condition" thread.  As
> I don't have a reproducer this is all just best guest so far, so handle
> it with care!

This looks promising.  Thanks for working on this.
Let me try to test it (albeit without a reproducer).
