Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574E69470
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 12:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719924316; cv=none; b=ZFH2gFAXfkEpAXioP+XDoDwNSAFpJFgXaJShh9jzsJSxrfScX5iAeVVUes20d8v2R1SmZfI7Vke3hDn33pIKsQuEM3BcMTksfi4HKufud7+BwsVhLxRZsW9QktJ78zjHOTBdnvqa6ei8Ttvb4ietnSA9kOm5Y2lUR0HcVxVh404=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719924316; c=relaxed/simple;
	bh=h7j8TJiNbtj7+2QchrwMqZ412OeiJHeaB27ukrxLc8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlJZhGRX4cfvAW0jSZTNd+X/M5xV83ql9VAvalO4yTEhXteVeSyVgeHhHEliAq69Lbbh+G3CoXlAkxJKyD/c1fHyqiP1PalQo7LEF5TYz83e3bzvLlVCzt2Q8oqPXfGX1xXzWj98gbJuLndJRKuhA9vR9DguBbkU7HSJOXNIy6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0t2ADps; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0t2ADps"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4ef56bdc3fcso1851807e0c.2
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2024 05:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719924314; x=1720529114; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h7j8TJiNbtj7+2QchrwMqZ412OeiJHeaB27ukrxLc8s=;
        b=h0t2ADpsefwytFaX8xf+lTZEJAjN1rmLvsiNpQyHKZIFx2zjDV5YY2LKd3D4TN+BZd
         mbsgXqsENzhV0/c4NQuk09sdSjYM7U8H4LgXO9ZKdHumhJIv/gVjZ/eM0G9Iip3Bouv+
         u3ZWbth3qH+FKgyggFx3fQJc6RTkXVcfROn8U1R8aD01qvUsAmYZgpnU/+q9JzuQPeee
         2KhwqS29SLJQYJpGG1Vs3WOGaMJ2yKv2qg+iXP4+gjrgIzKitescuM+oknuZcLUStawS
         WmxbEM0Qr2pjYgouR1knXSUo1dKCkKbn0maUyrc+zRfG1Fc5QChOOh24NySxL9CFsCnl
         cv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719924314; x=1720529114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7j8TJiNbtj7+2QchrwMqZ412OeiJHeaB27ukrxLc8s=;
        b=o0VYDDzkPOoHL+HGZHiKCHXnu6fWL4Pia0QvdegHa5yP3QKjPND82iYSoaw0z5+62z
         WQS5xkPN2qbVyN+JYt1g1/5qlCawsu7WpnYYV4ZiJw7S8YulzzzYv9DKtu2CUYNV/s2w
         GKoiVnEjEZWmaneX/7r6yL9KBvSirQlzUuJc36X1yDXnm3LYuRHlRI/M43D9R5oKNRY/
         H+tUlnCVMtLqWWmn4HGEoSKbJjBnIBBanzPwRIo8KtMZQ9pwjB2YU3aHwsH8xLpPk4nS
         LIFat6YCtL9lz7u43gbzim88b3cqHagVIDRseVTO14Qf0YTvkEaZqi0U54f25+4/99nI
         Gu2w==
X-Forwarded-Encrypted: i=1; AJvYcCVnGYpaOa+6zYDY/gqzkNg0nojCTK8T3NTfvVvpUSc9D6n9iZ5Y5OZqjaF6HaNep/y9mbFGNHNIsc7XSanZVKwIWIAUEsGCYLhDikU=
X-Gm-Message-State: AOJu0YxhH1+3fU/r9I+2/AO6h3FKJW7W6zYiX6T9ZxJ5EomUpl+jEcpE
	oLCtXgbJiSGhkAbR1VC9CH7bp4FT+Kh5q5MchCet65dJJtYN7c3Q7b0/tWRCws0LkhkLJX2qdjs
	M2m0fDJuMlgLzcAxsOT0UswGycw==
X-Google-Smtp-Source: AGHT+IGOvtfH2hj1DrsqHtNftpAAs+m1oZ0AbwVjM+mJfYhT47pRb78oXBjA4hbb4jkhoGJBouePd1hsQo16XMDwSbg=
X-Received: by 2002:a05:6122:198d:b0:4df:1a3f:2ec1 with SMTP id
 71dfb90a1353d-4f2a567232fmr9705219e0c.1.1719924314118; Tue, 02 Jul 2024
 05:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701050918.1244264-1-hch@lst.de> <20240701050918.1244264-2-hch@lst.de>
In-Reply-To: <20240701050918.1244264-2-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 2 Jul 2024 18:14:37 +0530
Message-ID: <CACzX3Au_vv7Kgwt7CaCSZtRU8Y80bmOyKK6PjgLwKe0GKUXVog@mail.gmail.com>
Subject: Re: [PATCH 1/5] block: split integrity support out of bio.h
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Looks good.
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
--
Anuj Gupta
