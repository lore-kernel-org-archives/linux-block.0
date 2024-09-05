Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ACF1A072C
	for <linux-block@vger.kernel.org>; Thu,  5 Sep 2024 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555404; cv=none; b=af5mCW4aQbJzLN4wEQu9YbWoSiJFQBW74jiFrU80vMp3nGzjUolqqXk8ES4H8q8bZvy4drueDmlhYmxcwFflQRlkcsz31KMNVxUM7bXAA9XnF+V0nggbGlklIt7Dz3eSy0NP86uXhaGSxorJTV/pgNk2GCpy6HK+3r5qCX43zgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555404; c=relaxed/simple;
	bh=uHqjy36mJjB7Y8neUhjFWgQCh0SpDtSG4PiN3ASD/xI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lshyuYiwfF/uZK8E+Jhd6x7rF5nSnwlJr337zanYqzL5DoS0IWgc1QNnearexITm8X/DEIjTn1hIE6dP6W/jbzmi3F1QhRRxQGgMO1RY3U54dcZfH7XalJuzGYHRYoPGWjvSPVaxuoGb3hcszPlsGF3CZWVZSeK8U9cwJBN0tO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GdEcEXAA; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GdEcEXAA"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e1a74ee4c0cso1217599276.2
        for <linux-block@vger.kernel.org>; Thu, 05 Sep 2024 09:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725555401; x=1726160201; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uHqjy36mJjB7Y8neUhjFWgQCh0SpDtSG4PiN3ASD/xI=;
        b=GdEcEXAAOyBCOCqUKERNIvQKW0wtu/qnou6xttaUgYSIHMaHuKkZvjEAVOm04KQf14
         hOXvGIwWkHcsLr4230mCgGRqM0G+h8lflFJbGijmeXzKBPb82g66VtSOytaizr9x4E3D
         38Pcr/xvoFlkF8KzrbxLEzppt0HHTioKRnaDs5Ge5boV+zegi8NRf+vgQfvKuuDzP0kv
         Dk4+YawDz+x8buPJ3Vc2ZkPsEH//4gpGJU5U/OZ+lc3OrKJDIKyrPcNSsiBCMPRrV4Qp
         ROfI4MAqa/CuX5jbKgLMKUo5Qw3Wzwy+JyXuB1rDm8/zvo5cfgSv5IKWq1qodMBo4efM
         Dmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725555401; x=1726160201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uHqjy36mJjB7Y8neUhjFWgQCh0SpDtSG4PiN3ASD/xI=;
        b=csWfUAZYPGf11zmHtcvUvjA3qI1JQS4P8tMdzJoaVK13SLwqYbfi2TnRSlbvGnlXYe
         +7r/PDg5+UkfkugKAmcecCykuzlyWDp7JXhqEwoBXxsIvyraPL6N1hUpU588LO+nC9Fo
         I9iE5/eOW5mbmmt+oIvtIYq/VwIr7tsn9vFMTyYOC3LUx++uXz3tXDFXKOLLC+DIUQVi
         0MgbTplpAPsILTMQunq+BVlHLXp2QBxaCLNrMp3j9kigw+0O8lFSlgZJ0C8AFcG7GbUm
         nc8cziqE7EVwhl5tcPVryV9J5/Nyj2mcIqKjV4yvHK9bwWS0K7uM7e3IpRNVFQwfAlxs
         S5DA==
X-Gm-Message-State: AOJu0YwmGsBGBEs+mQGTxGKWxBw3TMSKfIW9RGlghKOH2o8PiTIFn0+5
	ifjzmlFyNIeJXs0veA2/RnARWLnUWHfXL4Y3kwKMBOfNP1EIN7IoKY82eLeS5htJSncpWuoW+KF
	UXuXo1jhFTCXKTIptaT10X2rI32qNc/obJwEV9Q==
X-Google-Smtp-Source: AGHT+IHPSPP0a6x2pBeZdQ7cFMRpN5ue1U3qASJhoc2najQme0uesewUZpAlVDhvGq+pLja9rBnS0H5rCqWhKwKBoO4=
X-Received: by 2002:a05:6902:708:b0:e1a:5870:6380 with SMTP id
 3f1490d57ef6-e1a79fd8be7mr26837229276.17.1725555401330; Thu, 05 Sep 2024
 09:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905164344.186880-1-ulf.hansson@linaro.org> <b748a4aa-504b-4e58-9988-170e462401eb@kernel.dk>
In-Reply-To: <b748a4aa-504b-4e58-9988-170e462401eb@kernel.dk>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Sep 2024 18:56:04 +0200
Message-ID: <CAPDyKFrgzuuDBMWjBDVFAzwTP30JeD+zP2mVo+E=P0MZwUepHA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Move the BFQ io scheduler to Odd Fixes state
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
	Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai3@huawei.com>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org, Paolo Valente <paolo.valente@unimore.it>
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Sept 2024 at 18:49, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/5/24 10:43 AM, Ulf Hansson wrote:
> > To not give up entirely on maintenance of BFQ, add myself and Linus Walleij
> > as maintainers for BFQ. Although, as both of us has limited bandwidth for
> > this, let's reflect that by changing the state to Odd Fixes. If there are
> > anybody else that would be interested to help with maintenance of BFQ,
> > please let us know.
>
> We don't add maintainers that haven't actually worked on the code. As it
> so happens, we already have a good candidate for this, who knows the
> block layer code and does many fixes there, Yu Kuai. And they recently
> sent in real fixes too. So that's likely the way the needle will swing.

I would certainly appreciate it if Yu Kuai could step in and help,
that's why I cced him too.

Although, me and Linus were thinking that helping with "Odd Fixes" is
better than nothing. Ohh, well, let's see what Yu Kuai thinks, then.

Kind regards
Uffe
