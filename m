Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8C51FEFD9
	for <linux-block@vger.kernel.org>; Wed, 23 Oct 2024 22:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729724054; cv=none; b=PCjN7UFAMwT847h02XV6FbHV8zFqzFfNHmBqxrJylVarsNw24GbJhvRoEo5jacxkTkyE0zRM4YLCBuB8dJ1Iw4MmKgbOJy/Id5nROJ6xW9gEOMvVzXkqCgtrVR4UxqZAnrjqci9QLV7NNCDzJEsdvplugJLyvfFoaudEzcTjTSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729724054; c=relaxed/simple;
	bh=PFR9TpkH6Hc01YBVjmJdfznivV6Sm+HMMXv6JBlp4mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyEteS6rNjmQm091gBnRh5uCpsLdSmbD+lAW4tTAXRFi95whWQl3eiGgexLa3y9858ypO5QJgfFGJjQvP6XdhUdS+Wbfbxf5735Me2LTHdGjbQTk7dUmml9jwSrbroyP9t8/FVrbT5hWBmfOozy0UpWOF0PR12DyyMvQMygD4Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Rs0fuIBb; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Rs0fuIBb"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XYkr36rc5z6ClY8r;
	Wed, 23 Oct 2024 22:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1729724048; x=1732316049; bh=C1/OXZAsDG+8IggQYsxOIPC0
	QdY7YhDUAnpy9B40IMU=; b=Rs0fuIBbKAzIAGtD81YNC2xdoY+cfGWp2puCyWxe
	/LBy/eNyBI8k2mnQGOVjtNVL5WGdNrHI2GVy132SlcrWwJePV2AdkaJwEqrIQahw
	MLwjKfe7Ps6ZfINjq7nOVcKvQPZnV4MOXA+sUk9hllf4iMAiASmeSiY7ZcwSm7mT
	dOpV+UMjs+AWDxCBUtXNLVGvYrfi2Hql1o4fsJwPkR6s+YgKBfI/8eFR3tqwp6sD
	wq8E/gH6sp2MqarMoLX4JtGavHmcMVCDEsN+WHrWE7UAzc1Z6XLDOaIUmi7DrZKN
	piNwE3D0MzGCLm3cBgiRCUXlEyfbViUuBnmjJ9zoIoE9xg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Zy7GjDP2b8gP; Wed, 23 Oct 2024 22:54:08 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XYkqz464zz6ClY93;
	Wed, 23 Oct 2024 22:54:07 +0000 (UTC)
Message-ID: <04c6aca4-5960-4fe0-91e6-d5eab71b8703@acm.org>
Date: Wed, 23 Oct 2024 15:54:06 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix sanity checks in blk_rq_map_user_bvec
To: Uday Shankar <ushankar@purestorage.com>, Jens Axboe <axboe@kernel.dk>,
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Xinyu Zhang <xizhang@purestorage.com>
References: <20241023211519.4177873-1-ushankar@purestorage.com>
 <Zxl9wS2j5mUkye9o@dev-ushankar.dev.purestorage.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Zxl9wS2j5mUkye9o@dev-ushankar.dev.purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 10/23/24 3:50 PM, Uday Shankar wrote:
> For anyone interested, here are the details on how to reproduce the
> issue described above:
>=20
> # cat test.c
> #include <fcntl.h>
> #include <stdio.h>
> #include <string.h>
> #include <sys/ioctl.h>
> #include <liburing.h>
> #include <stdlib.h>
> #include <assert.h>
> #include <linux/nvme_ioctl.h>
>=20
> int main(int argc, char *argv[]) {
>      struct io_uring ring;
>=20
>      assert(io_uring_queue_init(1, &ring, IORING_SETUP_SQE128 | IORING_=
SETUP_CQE32) =3D=3D 0);
>=20
>      void *buf =3D memalign(4096, 2 * 4096);
>      printf("buf %p\n", buf);
>      struct iovec iov =3D {
>          .iov_base =3D buf,
>          .iov_len =3D 2 * 4096,
>      };
>=20
>      assert(io_uring_register_buffers(&ring, &iov, 1) =3D=3D 0);
>=20
>      struct io_uring_sqe *sqe =3D io_uring_get_sqe(&ring);
>      assert(sqe !=3D NULL);
>=20
>      int fd =3D open("/dev/ng0n1", O_RDONLY);
>      assert(fd > 0);
>      sqe->fd =3D fd;
>      sqe->opcode =3D IORING_OP_URING_CMD;
>      sqe->cmd_op =3D NVME_URING_CMD_IO;
>      sqe->buf_index =3D 0;
>      sqe->flags =3D 0;
>      sqe->uring_cmd_flags =3D IORING_URING_CMD_FIXED;
>=20
>      struct nvme_passthru_cmd *cmd =3D &sqe->cmd;
>      cmd->opcode =3D 2; // read
>      cmd->nsid =3D 1;
>      cmd->data_len =3D 1 * 4096;
>      cmd->addr =3D buf;
>=20
>      struct io_uring_cqe *cqe;
>      assert(io_uring_submit(&ring) =3D=3D 1);
>      assert(io_uring_wait_cqe(&ring, &cqe) =3D=3D 0);
>=20
>      printf("res %d\n", cqe->res);
>=20
>      return 0;
> }
> # gcc -o test -luring test.c
> test.c: In function =E2=80=98main=E2=80=99:
> test.c:15:17: warning: implicit declaration of function =E2=80=98memali=
gn=E2=80=99 [-Wimplicit-function-declaration]
>     15 |     void *buf =3D memalign(4096, 2 * 4096);
>        |                 ^~~~~~~~
> test.c:15:17: warning: initialization of =E2=80=98void *=E2=80=99 from =
=E2=80=98int=E2=80=99 makes pointer from integer without a cast [-Wint-co=
nversion]
> test.c:36:37: warning: initialization of =E2=80=98struct nvme_passthru_=
cmd *=E2=80=99 from incompatible pointer type =E2=80=98__u8 (*)[0]=E2=80=99=
 {aka =E2=80=98unsigned char (*)[]=E2=80=99} [-Wincompatible-pointer-type=
s]
>     36 |     struct nvme_passthru_cmd *cmd =3D &sqe->cmd;
>        |                                     ^
> test.c:40:15: warning: assignment to =E2=80=98__u64=E2=80=99 {aka =E2=80=
=98long long unsigned int=E2=80=99} from =E2=80=98void *=E2=80=99 makes i=
nteger from pointer without a cast [-Wint-conversion]
>     40 |     cmd->addr =3D buf;
>        |
> # ./test
> buf 0x406000
> res -22

Please convert the above code into a blktests pull request. See also
https://github.com/osandov/blktests.

Thanks,

Bart.


