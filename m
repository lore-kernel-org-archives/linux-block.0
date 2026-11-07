Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794076852;
	b=nYfjEj6+n17cE8x1TJkJzB5bmA2JUbzBVIdPOD/2NVQ3D19b75xxhOkCrS/DCdEpq2yh
	 RiZTTi7oHBTyM/7FuKCjf5/GACUej804aguhYGmo1Wh9gT+ExNa91/lpxWaCwZQDzITYd
	 4CQreKToa5bQ8nPenK2rrsVuUrpg+D543P1hVdqYQfN7yCatdp1Yq85mNL7DmVYKPhAKg
	 IcE0EGY1FK1YKfcV2egnWt6UmuNjiq8yLXFmIraEIXeXaiWX88GZw/mLdgESyEFNUiFXN
	 j1bhfHEMG4HXYLs25ZLh1ykBIJpYKTdIPbbHJBLD61jZiJ0eH6GPzHDQ4aYefAoF8Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794076852;
	h=DMARC-Filter:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=zdiEcxNwGVrB6YYalrXEx8Hp97b1eyb3JieGMsPO9nU=;
	b=Fcpxjl+nMZcLnONAV+BKa+cL1Cc4hMQwiHsV1d2Uy4LKmvmxS7uprrjf8jODg/abCDol
	 XrDaR8Lph2R2mQgyy/hUoAn65WCmZDErZlTtYu6MtiuoIeAzxXQETXR5EIopCt8+7007Q
	 JuHDehOSeNbOBRd4DKGbu5lYVyIM4Cr+n1Q5MT6RDScxH7x+Rc0bi8cg+ktVcTHtkdLoa
	 WZiSyX0rTa+sH267TWKVnIZM5PLEGjVVPjfWY7m3o0/IQgybOzdrywnEKPlAZ+Svhi0qV
	 46R6cB4GafIEABuozQBpnqZShawQkbAuZmtlJ7eAfigvjRuBqfVE4VXE+EQWzFUYAUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662AF606A32C;
	Sat,  7 Nov 2026 18:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 662AF606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAnwrencO9q3lCKAA--.26875S2;
	Sun, 08 Nov 2026 02:40:40 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Haris Iqbal <haris.iqbal@cloud.ionos.com>
Cc: axboe@kernel.dk, bvanassche@acm.org, danil.kipnis@cloud.ionos.com,
 jgg@ziepe.ca, jinpu.wang@ionos.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, vulab@iscas.ac.cn
Subject: Re: [PATCH] rnbd-srv: Fix sess_dev use-after-free in process_msg_close()
In-Reply-To: <CAJpMwyia7fYUOq=dj8E2FWnrtjZ9jHjZQSBW2vwB2vRBkbi2eA@mail.gmail.com>
References: <20260916094817.2007756-1-vulab@iscas.ac.cn>
 <CAJpMwyia7fYUOq=dj8E2FWnrtjZ9jHjZQSBW2vwB2vRBkbi2eA@mail.gmail.com>
Date: Sat, 07 Nov 2026 18:40:37 -0000
Message-ID: <179407683769.2688956.17160102252423154559@iscas.ac.cn>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAnwrencO9q3lCKAA--.26875S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4kAw1UuF4rtw1fXw1UZFb_yoW8Wr18pF
	yYkF4DArn0kr1IkFnrZa18WFy0yFW09a15Ar1furyUAay5Wa47trWftF1FvFZrCrs5Wa4j
	qFn0gws5A398Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
	7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfUw5l8UUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMEA2rvPcsj-QABsx

Hi Haris,

Sorry for the very late reply. Your message arrived when I was already
behind on this thread, and then it sat far longer than it should have.
That is my fault, not a sign that the report was unimportant.

I have now gone through the Sashiko report, and it is right: the patch is
wrong in exactly the way it describes.

process_msg_close() takes a kref with rnbd_get_sess_dev() and then calls
rnbd_srv_destroy_dev_session_sysfs(). That kobject_put() drops the last
kobject reference, so rnbd_srv_sess_dev_release() -> rnbd_destroy_sess_dev()
runs synchronously in the same thread, still under srv_sess->lock. That
function does rnbd_put_sess_dev() and then waits on destroy_comp, but the
reference this thread holds is only dropped after the wait returns. So a
single CLOSE from a client hangs the teardown thread with the session lock
held - I traded the race for a guaranteed deadlock, which is worse than
what I set out to fix.

While checking this against the current tree I also found that the race
itself has meanwhile been fixed upstream:

  4912dab88baa ("rnbd-srv: fix use-after-free on two CLOSE messages")

It takes srv_sess->lock first and looks the ID up with xa_load() under it,
so a second teardown of the same ID finds nothing. It is in v7.4-rc1, and
it also covers the force_close() interleaving that my patch was trying to
address. A v2 of my patch would therefore only duplicate work that is
already merged, so please drop this one - there is nothing here for you to
apply.

Thanks for pointing me at the Sashiko report.

Regards,
Wentao

