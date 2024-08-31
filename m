Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FB61DDF4;
	Sat, 31 Aug 2024 21:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725139860; cv=none; b=UCjVUo3+O6qQ4HiRZVZ4UuI4xMA5+q2prBq9vx3MbJL8YPFz/4i4NypKX+yR+pz1ZN45RnGhuA9jlhtOhvH0OsyvnGK18qqND8Hz5gmib3Jixk1E9iwWM2hsk/3gZHjAgQiazkTkW/8tQa08eqjOcShSKkLEvPfcy7Dllc50GMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725139860; c=relaxed/simple;
	bh=duA2XVQwh5Dvp5sYp8fyw3ohP/s5CW7DKISf+Rsng6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1WcLenizeZxek+1qHtUTXjVrbPI4plTxSq4YC6VOJXeLvOH5JbFkfY5yuzGKCSJqkk5Y/WdTwx0Yt3UBz04WJyAGDUGx49IGrIqCBVVA3Om/ngvpseW+tB7+atItln+V2nVUsQZ7CEaseEkigbI8DSrv8ke0IzocfSAhD4y51k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikKDf6oq; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikKDf6oq"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7c2595f5c35so347076a12.1;
        Sat, 31 Aug 2024 14:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725139858; x=1725744658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duA2XVQwh5Dvp5sYp8fyw3ohP/s5CW7DKISf+Rsng6s=;
        b=ikKDf6oq1GDbRfVd+fR4vwo2QTlICuSjdmX8N+cUPepTFOWy92f8ztHu4FjilTYHaD
         H23R23uNlDzztiVZfRFXXBgCw0Gm/bDcYIwmyGQW5DrgFPRkz7n7Zr6lTUrKEq0SPqx0
         FfPOr7LZc6CoByu+1Bsa5EMTn7gu8sAURX2TYcb4DOg0b8CeN+d3ZK+4onzUsWk9YiXu
         modd0uxjVqgWZmw+/dSYkznBNXCPau5O2utQmP1o38PMjq280Q1GdYZKSARSvFPzJHkK
         VkkcwZW6/5mTZguvM+zszumLQdcmOPYWjDBCRqCsXEOlkV27byzGmDRSjJkzBiryaapa
         YmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725139858; x=1725744658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duA2XVQwh5Dvp5sYp8fyw3ohP/s5CW7DKISf+Rsng6s=;
        b=e8N2QDaYK8DBqBwzglnCXcpBGNcs6HJp9tnyPbwvWROQLCHgMVhUg8uN8O/ox0SRLh
         qO8HFKFR14olgDAxPYAw8ninWK+YDZuiuU3Xd2JQw2DnBj/6p0tzGTKmiO6k0gxfXjAS
         KLqiJmb6oL5cUXtbdTg0JTXDBoTCJjbVIpFkEpHJDxeptR7lKfL3h07HhZkEze6GwxGh
         nSMG20sfS6YezMUhsHY1rrIqVJoQ6vSZVai17zD87epOHRS4y61h3txgUN+yktnnMDWH
         TS7DkcHzsVTI/uJy9MQ424DcAHG5RFbHBOQXX5qlG90ZjXRV8dVYveovOYtAEkbPg3W6
         LF5w==
X-Forwarded-Encrypted: i=1; AJvYcCUh2DLFT6Fopmm3DExZoyguix9mVm/Fbjos5oIoimA/t547bsCw/Sjd25zLXVekA1iF/tqapWx2N07WHQ==@vger.kernel.org, AJvYcCXcI1q9LjIu0jJTyQGkHquSkstk9pn8UvsMshu2BLgZ916Wqc4Nrc6dPH7haeHpoA4RSnIsAmiqJd208k46GBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqpW0OmEpc6STMZDy3eXiiApbx2ejPbthsR69uAKXgi3ADm5p3
	A9nYg+74FbXqyXRNDltHtGPfyJeUmkGSgx/VJiDsBdd7MvV8VGbyI7KXwRuROTquFu+HPOopxQH
	Ny9mhvdDd1OzOXD2it/g10uqJne0hkiTQ
X-Google-Smtp-Source: AGHT+IGS/8bNkcEVfWhG0O5eBsgojFycdPMsTyZexJ1Fq/O9HFe3IdUo4gtbge8U2m4GqwSgKngfC3fXgOjE3q/rdog=
X-Received: by 2002:a17:902:fc4c:b0:205:5410:8f58 with SMTP id
 d9443c01a7336-20554109056mr10668055ad.8.1725139857986; Sat, 31 Aug 2024
 14:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACVxJT-Hj6jdE0vwNrfGpKs73+ScTyxxxL8w_VXfoLAx79mr8w@mail.gmail.com>
 <CANiq72=pX32F4pDq85H=9pB=hmUcH59Xp7JoNGpKJ+XxkzovcQ@mail.gmail.com> <6ca8edb0-10f9-4967-b0d6-3510836fdbcf@p183>
In-Reply-To: <6ca8edb0-10f9-4967-b0d6-3510836fdbcf@p183>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 31 Aug 2024 23:30:45 +0200
Message-ID: <CANiq72mR_LrSunCYAgmbtVd0DriVpg0Y+PUe2opUmAPRbAjEKw@mail.gmail.com>
Subject: Re: [PATCH] block, rust: simplify validate_block_size() function
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Boqun Feng <boqun.feng@gmail.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 10:13=E2=80=AFPM Alexey Dobriyan <adobriyan@gmail.c=
om> wrote:
>
> Why do they duplicate the code 1:1?

I am not sure I understand your question. Documentation establishes
what a function is expected to do. Code implements the function.
Callers should not need to reverse engineer the design/code to take
advantage of a function.

Yes, in some cases, it may be trivial to infer what the function is
supposed to do by reading its implementation, and thus documentation
may seem redundant. But even in simple cases, one still needs to
assume the implementation has no bugs in order to do that. And in
non-trivial cases, the documentation is even more valuable.

It is true that in many places in the kernel there is not much code
documentation. However, for Rust code, we are trying to improve on
that.

Cheers,
Miguel
