Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94562F29
	for <linux-block@vger.kernel.org>; Wed, 29 Jan 2025 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738138294; cv=none; b=ITzFNV0I754csESPDAnbLbv8RJVsSWf8kidxZ+TjYiGZwbxw0XYkLiE1heK1scby59kAxbk57KKUfOQn9tJ2eSHc2KvVDerTIpvIKZrKNgPTqbZpLANpOquyD3VYHJxxSkEL6vCa2XoC3GUosUu6FuHJBhSpSot9rPw6eMzlQ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738138294; c=relaxed/simple;
	bh=7TB0ffPCp+6qx0DwGX7c0Qax/bnamRyLa0MseuVf5i8=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc:
	 References:In-Reply-To; b=Zw02FsSlThdh7KQ3QPGi0fpv7b4W0zamvyzbpK3dvGtKflGA79NJLVKROPnSLJi1uirhcLQDfVUA8gD/reLy5NDfLUk0XeJAiMI2m/7amcgwHdL5NX6SG9Vc7P29OFPNzfRXqXbjZ1dqZ7+uC98w4Bq3YgSrwSPY3w1KtJd/jtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0YZ/qdZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0YZ/qdZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E18EC4CED3;
	Wed, 29 Jan 2025 08:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738138294;
	bh=7TB0ffPCp+6qx0DwGX7c0Qax/bnamRyLa0MseuVf5i8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=W0YZ/qdZC054DzNwwZzuw6UTDxpvgR8gp8qKCxauaaCGX2LVvN9gjb/WLPZJjw0BM
	 SOd6dAdHbi7pmiAxV1/rfuYcHQf6AQaCczzrTjzhBuG0t2lOYFFmGjejY8041gmc37
	 hUflGF894dxMnDEG6MNMFxO5UZUT1V66DckEwtsAwEsZ++9EpPugwqqnseofO+1Oca
	 SYCERuPTsivPvl+PiA4JfN4PxeOqG7A90p98aLHyLIW8tN5NTGrzGNCw2+EJYptcg1
	 wLm0DHbrFwWM25Cx1FnuWOaPmt047HR8qqVD6m/qq0ceiXgkqI3H5QH7Ly/JuLIDXi
	 zITyNCQKiMYrw==
Content-Type: multipart/mixed; boundary="------------FXrC0bw5CzgNKC75swESoV8z"
Message-ID: <cb5d4dad-35a9-400e-9c53-785fba6f5a87@kernel.org>
Date: Wed, 29 Jan 2025 17:10:32 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 0/2] New zoned loop block device driver
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20250106142439.216598-1-dlemoal@kernel.org>
 <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk>
 <20250106152118.GB27324@lst.de> <Z33jJV6x1RnOLXvm@fedora>
 <ac42d762-60e5-4550-99f1-bd2072e474c2@kernel.org>
 <CAFj5m9+LUtAt2ST41KzMasx4BuVYBXjAuLg5MDr0Gh31yzZKzw@mail.gmail.com>
 <20250108090912.GA27786@lst.de> <Z35H1chBIvTt0luL@fedora>
 <Z4ETvfwVfzNWtgAo@fedora> <d5e59531-c19b-4332-8f47-b380ab9678be@kernel.org>
 <Z5OHy76X2F9H6EWP@fedora>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Z5OHy76X2F9H6EWP@fedora>

This is a multi-part message in MIME format.
--------------FXrC0bw5CzgNKC75swESoV8z
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/25 21:30, Ming Lei wrote:
>> 1 queue:
>> ========
>>                               +-------------------+-------------------+
>>                               | ublk (IOPS / BW)  | zloop (IOPS / BW) |
>>  +----------------------------+-------------------+-------------------+
>>  | QD=1,    4K rnd wr, 1 job  | 11.7k / 47.8 MB/s | 15.8k / 53.0 MB/s |
>>  | QD=32,   4K rnd wr, 8 jobs | 63.4k / 260 MB/s  | 101k / 413 MB/s   |
> 
> I can't reproduce the above two, actually not observe obvious difference
> between rublk/zoned and zloop in my test VM.

I am using bare-metal machines for these tests as I do not want any
noise from a VM/hypervisor in the numbers. And I did say that this is with a
tweaked version of zloop that I have not posted yet (I was waiting for rc1 to
repost as a rebase is needed to correct a compilation failure du to the nomerge
tage set flag being removed). I am attaching the patch I used here (it applies
on top of current Linus tree)

> Maybe rublk works at debug mode, which reduces perf by half usually.
> And you need to add device via 'cargo run -r -- add zoned' for using
> release mode.

Well, that is not an obvious thing for someone who does not know rust well. The
README file of rublk also does not mention that. So no, I did not run it like
this. I followed the README and call rublk directly. It would be great to
document that.

> Actually there is just single io_uring_enter() running in each ublk queue
> pthread, perf should be similar with kernel IO handling, and the main extra
> load is from the single syscall kernel/user context switch and IO data copy,
> and data copy effect can be neglected in small io size usually(< 64KB).
> 
>>  | QD=32, 128K rnd wr, 1 job  | 5008 / 656 MB/s   | 5993 / 786 MB/s   |
>>  | QD=32, 128K seq wr, 1 job  | 2636 / 346 MB/s   | 5393 / 707 MB/s   |
> 
> ublk 128K BS may be a little slower since there is one extra copy.

Here are newer numbers running rublk as you suggested (using cargo run -r).
The backend storage is on an XFS file system using a PCI gen4 4TB M.2 SSD that
is empty (the FS is empty on start). The emulated zoned disk has a capacity of
512GB with sequential zones only of 256 MB (that is, there are 2048
zones/files). Each data point is from a 1min run of fio.

On a 8-cores Intel Xeon test box, which has PCI gen 3 only, I get:

Single queue:
=============
                              +-------------------+-------------------+
                              | ublk (IOPS / BW)  | zloop (IOPS / BW) |
 +----------------------------+-------------------+-------------------+
 | QD=1,    4K rnd wr, 1 job  | 2859 / 11.7 MB/s  | 5535 / 22.7 MB/s  |
 | QD=32,   4K rnd wr, 8 jobs | 24.5k / 100 MB/s  | 24.6k / 101 MB/s  |
 | QD=32, 128K rnd wr, 1 job  | 14.9k / 1954 MB/s | 19.6k / 2571 MB/s |
 | QD=32, 128K seq wr, 1 job  | 1516 / 199 MB/s   | 10.6k / 1385 MB/s |
 +----------------------------+-------------------+-------------------+

8 queues:
=========
                              +-------------------+-------------------+
                              | ublk (IOPS / BW)  | zloop (IOPS / BW) |
 +----------------------------+-------------------+-------------------+
 | QD=1,    4K rnd wr, 1 job  | 5387 / 22.1 MB/s  | 5436 / 22.3 MB/s  |
 | QD=32,   4K rnd wr, 8 jobs | 16.4k / 67.0 MB/s | 26.3k / 108 MB/s  |
 | QD=32, 128K rnd wr, 1 job  | 6101 / 800 MB/s   | 19.8k / 2591 MB/s |
 | QD=32, 128K seq wr, 1 job  | 3987 / 523 MB/s   | 10.6k / 1391 MB/s |
 +----------------------------+-------------------+-------------------+

I have no idea why ublk is generally slower when setup with 8 I/O queues. The
qd=32 4K random write with 8 jobs is generally faster with ublk than zloop, but
that varies. I tracked that down to CPU utilization which is generally much
better (all CPUs used) with ublk compared to zloop, as zloop is at the mercy of
the workqueue code and how it schedules unbound work items.

Also, I do not understand why the sequential write workload is so much slower
with ublk. That baffles me and I have no explanations.

With a faster PCIe gen4 16-core AMD Epyc-2 machine, I get:

Single queue:
=============
                              +-------------------+-------------------+
                              | ublk (IOPS / BW)  | zloop (IOPS / BW) |
 +----------------------------+-------------------+-------------------+
 | QD=1,    4K rnd wr, 1 job  | 6824 / 28.0 MB/s  | 7320 / 30.0 MB/s  |
 | QD=32,   4K rnd wr, 8 jobs | 50.9k / 208 MB/s  | 41.7k / 171 MB/s  |
 | QD=32, 128K rnd wr, 1 job  | 15.6k / 2046 MB/s | 18.5k / 2430 MB/s |
 | QD=32, 128K seq wr, 1 job  | 6237 / 818 MB/s   | 22.5k / 2943 MB/s |
 +----------------------------+-------------------+-------------------+

8 queues:
=========
                              +-------------------+-------------------+
                              | ublk (IOPS / BW)  | zloop (IOPS / BW) |
 +----------------------------+-------------------+-------------------+
 | QD=1,    4K rnd wr, 1 job  | 6884 / 28.2 MB/s  | 7707 / 31.6 MB/s  |
 | QD=32,   4K rnd wr, 8 jobs | 39.4k / 161 MB/s  | 46.8k / 192 MB/s  |
 | QD=32, 128K rnd wr, 1 job  | 12.2k / 1597 MB/s | 18.8k / 2460 MB/s |
 | QD=32, 128K seq wr, 1 job  | 6391 / 799 MB/s   | 21.4k / 2802 MB/s |
 +----------------------------+-------------------+-------------------+

The same pattern repeats again: ublk with 8 queues is slower, but it is faster
with a single queue for the qd=32 4K random write with 8 jobs case.

> Simplicity need to be observed from multiple dimensions, 300 vs. 1500 LoC has
> shown something already, IMO.

Sure. But given the very complicated syntax of rust, a lower LoC for rust
compared to C is very subjective in my opinion.

I said "simplicity" in the context of the driver use. And rublk is not as
simple to use as zloop as it needs rust/cargo installed which is not an
acceptable dependency for xfstests. Furthermore, it is very annoying to have to
change the nofile ulimit to allow rublk to open all the zone files for a large
disk (zloop does not need that)

-- 
Damien Le Moal
Western Digital Research
--------------FXrC0bw5CzgNKC75swESoV8z
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-block-new-zoned-loop-block-device-driver.patch"
Content-Disposition: attachment;
 filename="0001-block-new-zoned-loop-block-device-driver.patch"
Content-Transfer-Encoding: base64

RnJvbSA4ZjFlMzE4YzRlNGZlMDU4MTRjM2U4Y2IxMzk5MmM4MDJhMzY1NDU4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYW1pZW4gTGUgTW9hbCA8ZGxlbW9hbEBrZXJuZWwu
b3JnPgpEYXRlOiBGcmksIDIwIERlYyAyMDI0IDA3OjU5OjA3ICswMDAwClN1YmplY3Q6IFtQ
QVRDSF0gYmxvY2s6IG5ldyB6b25lZCBsb29wIGJsb2NrIGRldmljZSBkcml2ZXIKClRoZSB6
b25lZCBsb29wIGJsb2NrIGRldmljZSBkcml2ZXIgYWxsb3dzIGEgdXNlciB0byBjcmVhdGUg
ZW11bGF0ZWQKem9uZWQgYmxvY2sgZGV2aWNlcyB1c2luZyBvbmUgcmVndWxhciBmaWxlIHBl
ciB6b25lIGFzIGJhY2tpbmcgc3RvcmFnZS4KQ29tcGFyZWQgdG8gbnVsbF9ibGsgb3Igc2Nz
aV9kZWJ1ZywgaXQgaGFzIHRoZSBhZHZhbnRhZ2Ugb2YgYWxsb3dpbmcKZW11bGF0aW5nIGxh
cmdlIHpvbmVkIGRldmljZXMgd2l0aG91dCByZXF1aXJpbmcgdGhlIHNhbWUgYW1vdW50IG9m
Cm1lbW9yeSBhcyB0aGUgY2FwYWNpdHkgb2YgdGhlIGVtdWxhdGVkIGRldmljZS4gRnVydGhl
cm1vcmUsIHpvbmVkCmRldmljZXMgZW11bGF0ZWQgd2l0aCB0aGlzIGRyaXZlciBjYW4gYmUg
cmUtc3RhcnRlZCBhZnRlciBhIGhvc3QgcmVib290CndpdGhvdXQgYW55IGxvc3Mgb2YgdGhl
IHN0YXRlIG9mIHRoZSBkZXZpY2Ugem9uZXMsIHdoaWNoIGlzIHNvbWV0aGluZwp0aGF0IG51
bGxfYmxrIGFuZCBzY3NpX2RlYnVnIGRvIG5vdCBzdXBwb3J0LgoKVGhpcyBpbml0aWFsIGlt
cGxlbWVudGF0aW9uIGlzIHNpbXBsZSBhbmQgZG9lcyBub3Qgc3VwcG9ydCB6b25lIHJlc291
cmNlCmxpbWl0cy4gVGhhdCBpcywgYSB6b25lZCBsb29wIGJsb2NrIGRldmljZSBsaW1pdHMg
Zm9yIHRoZSBtYXhpbXVtIG51bWJlcgpvZiBvcGVuIHpvbmVzIGFuZCBtYXhpbXVtIG51bWJl
ciBvZiBhY3RpdmUgem9uZXMgaXMgYWx3YXlzIDAuCgpUaGlzIGRyaXZlciBjYW4gYmUgZWl0
aGVyIGNvbXBpbGVkIGluLWtlcm5lbCBvciBhcyBhIG1vZHVsZSwgbmFtZWQKInpsb29wIi4g
Q29tcGlsYXRpb24gb2YgdGhpcyBkcml2ZXIgZGVwZW5kcyBvbiB0aGUgYmxvY2sgbGF5ZXIg
c3VwcG9ydApmb3Igem9uZWQgYmxvY2sgZGV2aWNlIChDT05GSUdfQkxLX0RFVl9aT05FRCBt
dXN0IGJlIHNldCkuCgpVc2luZyB0aGUgemxvb3AgZHJpdmVyIHRvIGNyZWF0ZSBhbmQgZGVs
ZXRlIHpvbmVkIGJsb2NrIGRldmljZXMgaXMKZG9uZSBieSB3cml0aW5nIGNvbW1hbmRzIHRv
IHRoZSB6b25lZCBsb29wIGNvbnRyb2wgY2hhcmFjdGVyIGRldmljZSBmaWxlCigvZGV2L3ps
b29wLWNvbnRyb2wpLiBDcmVhdGluZyBhIGRldmljZSBpcyBkb25lIHdpdGg6CgogICQgZWNo
byAiYWRkIFtvcHRpb25zXSIgPiAvZGV2L3psb29wLWNvbnRyb2wKClRoZSBvcHRpb25zIGF2
YWlsYWJsZSBmb3IgdGhlICJhZGQiIG9wZXJhdGlvbiBjYXQgYmUgbGlzdGVkIGJ5IHJlYWRp
bmcKdGhlIHpsb29wLWNvbnRyb2wgZGV2aWNlIGZpbGU6CgogICQgY2F0IC9kZXYvemxvb3At
Y29udHJvbAogIGFkZCBpZD0lZCxjYXBhY2l0eV9tYj0ldSx6b25lX3NpemVfbWI9JXUsem9u
ZV9jYXBhY2l0eV9tYj0ldSxjb252X3pvbmVzPSV1LGJhc2VfZGlyPSVzLG5yX3F1ZXVlcz0l
dSxxdWV1ZV9kZXB0aD0ldQogIHJlbW92ZSBpZD0lZAoKVGhlIG9wdGlvbnMgYXZhaWxhYmxl
IGFsbG93IGNvbnRyb2xsaW5nIHRoZSB6b25lZCBkZXZpY2UgdG90YWwKY2FwYWNpdHksIHpv
bmUgc2l6ZSwgem9uZSBjYXBhY3RpdHkgb2Ygc2VxdWVudGlhbCB6b25lcywgdG90YWwgbnVt
YmVyCm9mIGNvbnZlbnRpb25hbCB6b25lcywgYmFzZSBkaXJlY3RvcnkgZm9yIHRoZSB6b25l
cyBiYWNraW5nIGZpbGUsIG51bWJlcgpvZiBJL08gcXVldWVzIGFuZCB0aGUgbWF4aW11bSBx
dWV1ZSBkZXB0aCBvZiBJL08gcXVldWVzLgoKRGVsZXRpbmcgYSBkZXZpY2UgaXMgZG9uZSB1
c2luZyB0aGUgInJlbW92ZSIgY29tbWFuZDoKCiAgJCBlY2hvICJyZW1vdmUgaWQ9MCIgPiAv
ZGV2L3psb29wLWNvbnRyb2wKClRoaXMgaW1wbGVtZW50YXRpb24gcGFzc2VzIHZhcmlvdXMg
dGVzdHMgdXNpbmcgem9uZWZzIGFuZCBmaW8gKHQvemJkCnRlc3RzKSBhbmQgcHJvdmlkZXMg
YSBzdGF0ZSBtYWNoaW5lIGZvciB6b25lIGNvbmRpdGlvbnMgdGhhdCBpcwpjb21wbGlhbnQg
d2l0aCB0aGUgVDEwIFpCQyBhbmQgTlZNZSBaTlMgc3BlY2lmaWNhdGlvbnMuCgpDby1kZXZl
bG9wZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgpTaWduZWQtb2ZmLWJ5
OiBEYW1pZW4gTGUgTW9hbCA8ZGxlbW9hbEBrZXJuZWwub3JnPgotLS0KIE1BSU5UQUlORVJT
ICAgICAgICAgICAgfCAgICA3ICsKIGRyaXZlcnMvYmxvY2svS2NvbmZpZyAgfCAgIDE2ICsK
IGRyaXZlcnMvYmxvY2svTWFrZWZpbGUgfCAgICAxICsKIGRyaXZlcnMvYmxvY2svemxvb3Au
YyAgfCAxMzM4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDQg
ZmlsZXMgY2hhbmdlZCwgMTM2MiBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9ibG9jay96bG9vcC5jCgpkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlO
VEFJTkVSUwppbmRleCA5MzZlODBmMmM5Y2UuLjk2MzI1ZjQ4N2IzZSAxMDA2NDQKLS0tIGEv
TUFJTlRBSU5FUlMKKysrIGIvTUFJTlRBSU5FUlMKQEAgLTI2MTUyLDYgKzI2MTUyLDEzIEBA
IEw6CWxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKIFM6CU1haW50YWluZWQKIEY6CWFy
Y2gveDg2L2tlcm5lbC9jcHUvemhhb3hpbi5jCiAKK1pPTkVEIExPT1AgREVWSUNFCitNOglE
YW1pZW4gTGUgTW9hbCA8ZGxlbW9hbEBrZXJuZWwub3JnPgorUjoJQ2hyaXN0b3BoIEhlbGx3
aWcgPGhjaEBsc3QuZGU+CitMOglsaW51eC1ibG9ja0B2Z2VyLmtlcm5lbC5vcmcKK1M6CU1h
aW50YWluZWQKK0Y6CWRyaXZlcnMvYmxvY2svemxvb3AuYworCiBaT05FRlMgRklMRVNZU1RF
TQogTToJRGFtaWVuIExlIE1vYWwgPGRsZW1vYWxAa2VybmVsLm9yZz4KIE06CU5hb2hpcm8g
QW90YSA8bmFvaGlyby5hb3RhQHdkYy5jb20+CmRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2Nr
L0tjb25maWcgYi9kcml2ZXJzL2Jsb2NrL0tjb25maWcKaW5kZXggYTk3ZjJjNDBjNjQwLi5h
YmRiZTVkNDkwMjYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYmxvY2svS2NvbmZpZworKysgYi9k
cml2ZXJzL2Jsb2NrL0tjb25maWcKQEAgLTQxMyw0ICs0MTMsMjAgQEAgY29uZmlnIEJMS0RF
Vl9VQkxLX0xFR0FDWV9PUENPREVTCiAKIHNvdXJjZSAiZHJpdmVycy9ibG9jay9ybmJkL0tj
b25maWciCiAKK2NvbmZpZyBCTEtfREVWX1pPTkVEX0xPT1AKKwl0cmlzdGF0ZSAiWm9uZWQg
bG9vcGJhY2sgZGV2aWNlIHN1cHBvcnQiCisJZGVwZW5kcyBvbiBCTEtfREVWX1pPTkVECisJ
aGVscAorCSAgU2F5aW5nIFkgaGVyZSB3aWxsIGFsbG93IHlvdSB0byB1c2UgY3JlYXRlIGEg
em9uZWQgYmxvY2sgZGV2aWNlIHVzaW5nCisJICByZWd1bGFyIGZpbGVzIGZvciB6b25lcyAo
b25lIGZpbGUgcGVyIHpvbmVzKS4gVGhpcyBpcyB1c2VmdWwgdG8gdGVzdAorCSAgZmlsZSBz
eXN0ZW1zLCBkZXZpY2UgbWFwcGVyIGFuZCBhcHBsaWNhdGlvbnMgdGhhdCBzdXBwb3J0IHpv
bmVkIGJsb2NrCisJICBkZXZpY2VzLiBUbyBjcmVhdGUgYSB6b25lZCBsb29wIGRldmljZSwg
bm8gdXNlciB1dGlsaXR5IGlzIG5lZWRlZCwgYQorCSAgem9uZWQgbG9vcCBkZXZpY2UgY2Fu
IGJlIGNyZWF0ZWQgKG9yIHJlLXN0YXJ0ZWQpIHVzaW5nIGEgY29tbWFuZAorCSAgbGlrZToK
KworCSAgZWNobyAiYWRkIGlkPTAsem9uZV9zaXplX21iPTI1NixjYXBhY2l0eV9tYj0xNjM4
NCxjb252X3pvbmVzPTExIiA+IFwKKwkJL2Rldi96bG9vcC1jb250cm9sCisKKwkgIElmIHVu
c3VyZSwgc2F5IE4uCisKIGVuZGlmICMgQkxLX0RFVgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9i
bG9jay9NYWtlZmlsZSBiL2RyaXZlcnMvYmxvY2svTWFrZWZpbGUKaW5kZXggMTEwNWEyZDRm
ZGNiLi4wOTc3MDdhY2E3MjUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYmxvY2svTWFrZWZpbGUK
KysrIGIvZHJpdmVycy9ibG9jay9NYWtlZmlsZQpAQCAtNDEsNSArNDEsNiBAQCBvYmotJChD
T05GSUdfQkxLX0RFVl9STkJEKQkrPSBybmJkLwogb2JqLSQoQ09ORklHX0JMS19ERVZfTlVM
TF9CTEspCSs9IG51bGxfYmxrLwogCiBvYmotJChDT05GSUdfQkxLX0RFVl9VQkxLKQkJCSs9
IHVibGtfZHJ2Lm8KK29iai0kKENPTkZJR19CTEtfREVWX1pPTkVEX0xPT1ApICs9IHpsb29w
Lm8KIAogc3dpbV9tb2QteQk6PSBzd2ltLm8gc3dpbV9hc20ubwpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ibG9jay96bG9vcC5jIGIvZHJpdmVycy9ibG9jay96bG9vcC5jCm5ldyBmaWxlIG1v
ZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uYjIzNDFiYjEzNTI4Ci0tLSAvZGV2L251
bGwKKysrIGIvZHJpdmVycy9ibG9jay96bG9vcC5jCkBAIC0wLDAgKzEsMTMzOCBAQAorLy8g
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQorLyoKKyAqIENvcHlyaWdo
dCAoYykgMjAyNSwgQ2hyaXN0b3BoIEhlbGx3aWcuCisgKiBDb3B5cmlnaHQgKGMpIDIwMjUs
IFdlc3Rlcm4gRGlnaXRhbCBDb3Jwb3JhdGlvbiBvciBpdHMgYWZmaWxpYXRlcy4KKyAqCisg
KiBab25lZCBMb29wIERldmljZSBkcml2ZXIgLSBleHBvcnRzIGEgem9uZWQgYmxvY2sgZGV2
aWNlIHVzaW5nIG9uZSBmaWxlIHBlcgorICogem9uZSBhcyBiYWNraW5nIHN0b3JhZ2UuCisg
Ki8KKyNkZWZpbmUgcHJfZm10KGZtdCkgS0JVSUxEX01PRE5BTUUgIjogIiBmbXQKKworI2lu
Y2x1ZGUgPGxpbnV4L21vZHVsZS5oPgorI2luY2x1ZGUgPGxpbnV4L2Jsay1tcS5oPgorI2lu
Y2x1ZGUgPGxpbnV4L2Jsa3pvbmVkLmg+CisjaW5jbHVkZSA8bGludXgvcGFnZW1hcC5oPgor
I2luY2x1ZGUgPGxpbnV4L21pc2NkZXZpY2UuaD4KKyNpbmNsdWRlIDxsaW51eC9mYWxsb2Mu
aD4KKyNpbmNsdWRlIDxsaW51eC9tdXRleC5oPgorI2luY2x1ZGUgPGxpbnV4L3BhcnNlci5o
PgorI2luY2x1ZGUgPGxpbnV4L3NlcV9maWxlLmg+CisKKy8qCisgKiBPcHRpb25zIGZvciBh
ZGRpbmcgKGFuZCByZW1vdmluZykgYSBkZXZpY2UuCisgKi8KK2VudW0geworCVpMT09QX09Q
VF9FUlIJCQk9IDAsCisJWkxPT1BfT1BUX0lECQkJPSAoMSA8PCAwKSwKKwlaTE9PUF9PUFRf
Q0FQQUNJVFkJCT0gKDEgPDwgMSksCisJWkxPT1BfT1BUX1pPTkVfU0laRQkJPSAoMSA8PCAy
KSwKKwlaTE9PUF9PUFRfWk9ORV9DQVBBQ0lUWQkJPSAoMSA8PCAzKSwKKwlaTE9PUF9PUFRf
TlJfQ09OVl9aT05FUwkJPSAoMSA8PCA0KSwKKwlaTE9PUF9PUFRfQkFTRV9ESVIJCT0gKDEg
PDwgNSksCisJWkxPT1BfT1BUX05SX1FVRVVFUwkJPSAoMSA8PCA2KSwKKwlaTE9PUF9PUFRf
UVVFVUVfREVQVEgJCT0gKDEgPDwgNyksCisJWkxPT1BfT1BUX0JVRkZFUkVEX0lPCQk9ICgx
IDw8IDgpLAorfTsKKworc3RhdGljIGNvbnN0IG1hdGNoX3RhYmxlX3Qgemxvb3Bfb3B0X3Rv
a2VucyA9IHsKKwl7IFpMT09QX09QVF9JRCwJCQkiaWQ9JWQiCX0sCisJeyBaTE9PUF9PUFRf
Q0FQQUNJVFksCQkiY2FwYWNpdHlfbWI9JXUiCX0sCisJeyBaTE9PUF9PUFRfWk9ORV9TSVpF
LAkJInpvbmVfc2l6ZV9tYj0ldSIJfSwKKwl7IFpMT09QX09QVF9aT05FX0NBUEFDSVRZLAki
em9uZV9jYXBhY2l0eV9tYj0ldSIJfSwKKwl7IFpMT09QX09QVF9OUl9DT05WX1pPTkVTLAki
Y29udl96b25lcz0ldSIJCX0sCisJeyBaTE9PUF9PUFRfQkFTRV9ESVIsCQkiYmFzZV9kaXI9
JXMiCQl9LAorCXsgWkxPT1BfT1BUX05SX1FVRVVFUywJCSJucl9xdWV1ZXM9JXUiCQl9LAor
CXsgWkxPT1BfT1BUX1FVRVVFX0RFUFRILAkicXVldWVfZGVwdGg9JXUiCX0sCisJeyBaTE9P
UF9PUFRfQlVGRkVSRURfSU8sCSJidWZmZXJlZF9pbyIJCX0sCisJeyBaTE9PUF9PUFRfRVJS
LAkJTlVMTAkJCX0KK307CisKKy8qIERlZmF1bHQgdmFsdWVzIGZvciB0aGUgImFkZCIgb3Bl
cmF0aW9uLiAqLworI2RlZmluZSBaTE9PUF9ERUZfSUQJCQktMQorI2RlZmluZSBaTE9PUF9E
RUZfWk9ORV9TSVpFCQkoKDI1NlVMTCAqIFNaXzFNKSA+PiBTRUNUT1JfU0hJRlQpCisjZGVm
aW5lIFpMT09QX0RFRl9OUl9aT05FUwkJNjQKKyNkZWZpbmUgWkxPT1BfREVGX05SX0NPTlZf
Wk9ORVMJCTgKKyNkZWZpbmUgWkxPT1BfREVGX0JBU0VfRElSCQkiL3Zhci9sb2NhbC96bG9v
cCIKKyNkZWZpbmUgWkxPT1BfREVGX05SX1FVRVVFUwkJMQorI2RlZmluZSBaTE9PUF9ERUZf
UVVFVUVfREVQVEgJCTEyOAorI2RlZmluZSBaTE9PUF9ERUZfQlVGRkVSRURfSU8JCWZhbHNl
CisKKy8qIEFyYml0cmFyeSBsaW1pdCBvbiB0aGUgem9uZSBzaXplICgxNkdCKS4gKi8KKyNk
ZWZpbmUgWkxPT1BfTUFYX1pPTkVfU0laRV9NQgkJMTYzODQKKworc3RydWN0IHpsb29wX29w
dGlvbnMgeworCXVuc2lnbmVkIGludAkJbWFzazsKKwlpbnQJCQlpZDsKKwlzZWN0b3JfdAkJ
Y2FwYWNpdHk7CisJc2VjdG9yX3QJCXpvbmVfc2l6ZTsKKwlzZWN0b3JfdAkJem9uZV9jYXBh
Y2l0eTsKKwl1bnNpZ25lZCBpbnQJCW5yX2NvbnZfem9uZXM7CisJY2hhcgkJCSpiYXNlX2Rp
cjsKKwl1bnNpZ25lZCBpbnQJCW5yX3F1ZXVlczsKKwl1bnNpZ25lZCBpbnQJCXF1ZXVlX2Rl
cHRoOworCWJvb2wJCQlidWZmZXJlZF9pbzsKK307CisKKy8qCisgKiBEZXZpY2Ugc3RhdGVz
LgorICovCitlbnVtIHsKKwlabG9fY3JlYXRpbmcgPSAwLAorCVpsb19saXZlLAorCVpsb19k
ZWxldGluZywKK307CisKK2VudW0gemxvb3Bfem9uZV9mbGFncyB7CisJWkxPT1BfWk9ORV9D
T05WID0gMCwKKwlaTE9PUF9aT05FX1NFUV9FUlJPUiwKK307CisKK3N0cnVjdCB6bG9vcF96
b25lIHsKKwlzdHJ1Y3QgZmlsZQkJKmZpbGU7CisKKwl1bnNpZ25lZCBsb25nCQlmbGFnczsK
KwlzdHJ1Y3QgbXV0ZXgJCWxvY2s7CisJZW51bSBibGtfem9uZV9jb25kCWNvbmQ7CisJc2Vj
dG9yX3QJCXN0YXJ0OworCXNlY3Rvcl90CQl3cDsKKworCWdmcF90CQkJb2xkX2dmcF9tYXNr
OworfTsKKworc3RydWN0IHpsb29wX2RldmljZSB7CisJdW5zaWduZWQgaW50CQlpZDsKKwl1
bnNpZ25lZCBpbnQJCXN0YXRlOworCisJc3RydWN0IGJsa19tcV90YWdfc2V0CXRhZ19zZXQ7
CisJc3RydWN0IGdlbmRpc2sJCSpkaXNrOworCisJc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3Qg
KndvcmtxdWV1ZTsKKwlib29sCQkJYnVmZmVyZWRfaW87CisKKwljb25zdCBjaGFyCQkqYmFz
ZV9kaXI7CisJc3RydWN0IGZpbGUJCSpkYXRhX2RpcjsKKworCXVuc2lnbmVkIGludAkJem9u
ZV9zaGlmdDsKKwlzZWN0b3JfdAkJem9uZV9zaXplOworCXNlY3Rvcl90CQl6b25lX2NhcGFj
aXR5OworCXVuc2lnbmVkIGludAkJbnJfem9uZXM7CisJdW5zaWduZWQgaW50CQlucl9jb252
X3pvbmVzOworCisJc3RydWN0IHpsb29wX3pvbmUJem9uZXNbXSBfX2NvdW50ZWRfYnkobnJf
em9uZXMpOworfTsKKworc3RydWN0IHpsb29wX2NtZCB7CisJc3RydWN0IHdvcmtfc3RydWN0
CXdvcms7CisJYXRvbWljX3QJCXJlZjsKKwlzZWN0b3JfdAkJc2VjdG9yOworCXNlY3Rvcl90
CQlucl9zZWN0b3JzOworCWxvbmcJCQlyZXQ7CisJc3RydWN0IGtpb2NiCQlpb2NiOworCXN0
cnVjdCBiaW9fdmVjCQkqYnZlYzsKK307CisKK3N0YXRpYyBERUZJTkVfSURSKHpsb29wX2lu
ZGV4X2lkcik7CitzdGF0aWMgREVGSU5FX01VVEVYKHpsb29wX2N0bF9tdXRleCk7CisKK3N0
YXRpYyB1bnNpZ25lZCBpbnQgcnFfem9uZV9ubyhzdHJ1Y3QgcmVxdWVzdCAqcnEpCit7CisJ
c3RydWN0IHpsb29wX2RldmljZSAqemxvID0gcnEtPnEtPnF1ZXVlZGF0YTsKKworCXJldHVy
biBibGtfcnFfcG9zKHJxKSA+PiB6bG8tPnpvbmVfc2hpZnQ7Cit9CisKK3N0YXRpYyBpbnQg
emxvb3BfdXBkYXRlX3NlcV96b25lKHN0cnVjdCB6bG9vcF9kZXZpY2UgKnpsbywgdW5zaWdu
ZWQgaW50IHpvbmVfbm8pCit7CisJc3RydWN0IHpsb29wX3pvbmUgKnpvbmUgPSAmemxvLT56
b25lc1t6b25lX25vXTsKKwlzdHJ1Y3Qga3N0YXQgc3RhdDsKKwlzZWN0b3JfdCBmaWxlX3Nl
Y3RvcnM7CisJaW50IHJldDsKKworCWxvY2tkZXBfYXNzZXJ0X2hlbGQoJnpvbmUtPmxvY2sp
OworCisJcmV0ID0gdmZzX2dldGF0dHIoJnpvbmUtPmZpbGUtPmZfcGF0aCwgJnN0YXQsIFNU
QVRYX1NJWkUsIDApOworCWlmIChyZXQgPCAwKSB7CisJCXByX2VycigiRmFpbGVkIHRvIGdl
dCB6b25lICV1IGZpbGUgc3RhdCAoZXJyPSVkKVxuIiwKKwkJICAgICAgIHpvbmVfbm8sIHJl
dCk7CisJCXNldF9iaXQoWkxPT1BfWk9ORV9TRVFfRVJST1IsICZ6b25lLT5mbGFncyk7CisJ
CXJldHVybiByZXQ7CisJfQorCisJZmlsZV9zZWN0b3JzID0gc3RhdC5zaXplID4+IFNFQ1RP
Ul9TSElGVDsKKwlpZiAoZmlsZV9zZWN0b3JzID4gemxvLT56b25lX2NhcGFjaXR5KSB7CisJ
CXByX2VycigiWm9uZSAldSBmaWxlIHRvbyBsYXJnZSAoJWxsdSBzZWN0b3JzID4gJWxsdSlc
biIsCisJCSAgICAgICB6b25lX25vLCBmaWxlX3NlY3RvcnMsIHpsby0+em9uZV9jYXBhY2l0
eSk7CisJCXJldHVybiAtRUlOVkFMOworCX0KKworCWlmICghZmlsZV9zZWN0b3JzKSB7CisJ
CXpvbmUtPmNvbmQgPSBCTEtfWk9ORV9DT05EX0VNUFRZOworCQl6b25lLT53cCA9IHpvbmUt
PnN0YXJ0OworCX0gZWxzZSBpZiAoZmlsZV9zZWN0b3JzID09IHpsby0+em9uZV9jYXBhY2l0
eSkgeworCQl6b25lLT5jb25kID0gQkxLX1pPTkVfQ09ORF9GVUxMOworCQl6b25lLT53cCA9
IHpvbmUtPnN0YXJ0ICsgemxvLT56b25lX3NpemU7CisJfSBlbHNlIHsKKwkJem9uZS0+Y29u
ZCA9IEJMS19aT05FX0NPTkRfQ0xPU0VEOworCQl6b25lLT53cCA9IHpvbmUtPnN0YXJ0ICsg
ZmlsZV9zZWN0b3JzOworCX0KKworCXJldHVybiAwOworfQorCitzdGF0aWMgaW50IHpsb29w
X29wZW5fem9uZShzdHJ1Y3Qgemxvb3BfZGV2aWNlICp6bG8sIHVuc2lnbmVkIGludCB6b25l
X25vKQoreworCXN0cnVjdCB6bG9vcF96b25lICp6b25lID0gJnpsby0+em9uZXNbem9uZV9u
b107CisJaW50IHJldCA9IDA7CisKKwlpZiAodGVzdF9iaXQoWkxPT1BfWk9ORV9DT05WLCAm
em9uZS0+ZmxhZ3MpKQorCQlyZXR1cm4gLUVJTzsKKworCW11dGV4X2xvY2soJnpvbmUtPmxv
Y2spOworCisJaWYgKHRlc3RfYW5kX2NsZWFyX2JpdChaTE9PUF9aT05FX1NFUV9FUlJPUiwg
JnpvbmUtPmZsYWdzKSkgeworCQlyZXQgPSB6bG9vcF91cGRhdGVfc2VxX3pvbmUoemxvLCB6
b25lX25vKTsKKwkJaWYgKHJldCkKKwkJCWdvdG8gdW5sb2NrOworCX0KKworCXN3aXRjaCAo
em9uZS0+Y29uZCkgeworCWNhc2UgQkxLX1pPTkVfQ09ORF9FWFBfT1BFTjoKKwkJYnJlYWs7
CisJY2FzZSBCTEtfWk9ORV9DT05EX0VNUFRZOgorCWNhc2UgQkxLX1pPTkVfQ09ORF9DTE9T
RUQ6CisJY2FzZSBCTEtfWk9ORV9DT05EX0lNUF9PUEVOOgorCQl6b25lLT5jb25kID0gQkxL
X1pPTkVfQ09ORF9FWFBfT1BFTjsKKwkJYnJlYWs7CisJY2FzZSBCTEtfWk9ORV9DT05EX0ZV
TEw6CisJZGVmYXVsdDoKKwkJcmV0ID0gLUVJTzsKKwkJYnJlYWs7CisJfQorCit1bmxvY2s6
CisJbXV0ZXhfdW5sb2NrKCZ6b25lLT5sb2NrKTsKKworCXJldHVybiByZXQ7Cit9CisKK3N0
YXRpYyBpbnQgemxvb3BfY2xvc2Vfem9uZShzdHJ1Y3Qgemxvb3BfZGV2aWNlICp6bG8sIHVu
c2lnbmVkIGludCB6b25lX25vKQoreworCXN0cnVjdCB6bG9vcF96b25lICp6b25lID0gJnps
by0+em9uZXNbem9uZV9ub107CisJaW50IHJldCA9IDA7CisKKwlpZiAodGVzdF9iaXQoWkxP
T1BfWk9ORV9DT05WLCAmem9uZS0+ZmxhZ3MpKQorCQlyZXR1cm4gLUVJTzsKKworCW11dGV4
X2xvY2soJnpvbmUtPmxvY2spOworCisJaWYgKHRlc3RfYW5kX2NsZWFyX2JpdChaTE9PUF9a
T05FX1NFUV9FUlJPUiwgJnpvbmUtPmZsYWdzKSkgeworCQlyZXQgPSB6bG9vcF91cGRhdGVf
c2VxX3pvbmUoemxvLCB6b25lX25vKTsKKwkJaWYgKHJldCkKKwkJCWdvdG8gdW5sb2NrOwor
CX0KKworCXN3aXRjaCAoem9uZS0+Y29uZCkgeworCWNhc2UgQkxLX1pPTkVfQ09ORF9DTE9T
RUQ6CisJCWJyZWFrOworCWNhc2UgQkxLX1pPTkVfQ09ORF9JTVBfT1BFTjoKKwljYXNlIEJM
S19aT05FX0NPTkRfRVhQX09QRU46CisJCWlmICh6b25lLT53cCA9PSB6b25lLT5zdGFydCkK
KwkJCXpvbmUtPmNvbmQgPSBCTEtfWk9ORV9DT05EX0VNUFRZOworCQllbHNlCisJCQl6b25l
LT5jb25kID0gQkxLX1pPTkVfQ09ORF9DTE9TRUQ7CisJCWJyZWFrOworCWNhc2UgQkxLX1pP
TkVfQ09ORF9FTVBUWToKKwljYXNlIEJMS19aT05FX0NPTkRfRlVMTDoKKwlkZWZhdWx0Ogor
CQlyZXQgPSAtRUlPOworCQlicmVhazsKKwl9CisKK3VubG9jazoKKwltdXRleF91bmxvY2so
JnpvbmUtPmxvY2spOworCisJcmV0dXJuIHJldDsKK30KKworc3RhdGljIGludCB6bG9vcF9y
ZXNldF96b25lKHN0cnVjdCB6bG9vcF9kZXZpY2UgKnpsbywgdW5zaWduZWQgaW50IHpvbmVf
bm8pCit7CisJc3RydWN0IHpsb29wX3pvbmUgKnpvbmUgPSAmemxvLT56b25lc1t6b25lX25v
XTsKKwlpbnQgcmV0ID0gMDsKKworCWlmICh0ZXN0X2JpdChaTE9PUF9aT05FX0NPTlYsICZ6
b25lLT5mbGFncykpCisJCXJldHVybiAtRUlPOworCisJbXV0ZXhfbG9jaygmem9uZS0+bG9j
ayk7CisKKwlpZiAoIXRlc3RfYml0KFpMT09QX1pPTkVfU0VRX0VSUk9SLCAmem9uZS0+Zmxh
Z3MpICYmCisJICAgIHpvbmUtPmNvbmQgPT0gQkxLX1pPTkVfQ09ORF9FTVBUWSkKKwkJZ290
byB1bmxvY2s7CisKKwlpZiAodmZzX3RydW5jYXRlKCZ6b25lLT5maWxlLT5mX3BhdGgsIDAp
KSB7CisJCXNldF9iaXQoWkxPT1BfWk9ORV9TRVFfRVJST1IsICZ6b25lLT5mbGFncyk7CisJ
CXJldCA9IC1FSU87CisJCWdvdG8gdW5sb2NrOworCX0KKworCXpvbmUtPmNvbmQgPSBCTEtf
Wk9ORV9DT05EX0VNUFRZOworCXpvbmUtPndwID0gem9uZS0+c3RhcnQ7CisJY2xlYXJfYml0
KFpMT09QX1pPTkVfU0VRX0VSUk9SLCAmem9uZS0+ZmxhZ3MpOworCit1bmxvY2s6CisJbXV0
ZXhfdW5sb2NrKCZ6b25lLT5sb2NrKTsKKworCXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyBp
bnQgemxvb3BfcmVzZXRfYWxsX3pvbmVzKHN0cnVjdCB6bG9vcF9kZXZpY2UgKnpsbykKK3sK
Kwl1bnNpZ25lZCBpbnQgaTsKKwlpbnQgcmV0OworCisJZm9yIChpID0gemxvLT5ucl9jb252
X3pvbmVzOyBpIDwgemxvLT5ucl96b25lczsgaSsrKSB7CisJCXJldCA9IHpsb29wX3Jlc2V0
X3pvbmUoemxvLCBpKTsKKwkJaWYgKHJldCkKKwkJCXJldHVybiByZXQ7CisJfQorCisJcmV0
dXJuIDA7Cit9CisKK3N0YXRpYyBpbnQgemxvb3BfZmluaXNoX3pvbmUoc3RydWN0IHpsb29w
X2RldmljZSAqemxvLCB1bnNpZ25lZCBpbnQgem9uZV9ubykKK3sKKwlzdHJ1Y3Qgemxvb3Bf
em9uZSAqem9uZSA9ICZ6bG8tPnpvbmVzW3pvbmVfbm9dOworCWludCByZXQgPSAwOworCisJ
aWYgKHRlc3RfYml0KFpMT09QX1pPTkVfQ09OViwgJnpvbmUtPmZsYWdzKSkKKwkJcmV0dXJu
IC1FSU87CisKKwltdXRleF9sb2NrKCZ6b25lLT5sb2NrKTsKKworCWlmICghdGVzdF9iaXQo
WkxPT1BfWk9ORV9TRVFfRVJST1IsICZ6b25lLT5mbGFncykgJiYKKwkgICAgem9uZS0+Y29u
ZCA9PSBCTEtfWk9ORV9DT05EX0ZVTEwpCisJCWdvdG8gdW5sb2NrOworCisJaWYgKHZmc190
cnVuY2F0ZSgmem9uZS0+ZmlsZS0+Zl9wYXRoLCB6bG8tPnpvbmVfc2l6ZSA8PCBTRUNUT1Jf
U0hJRlQpKSB7CisJCXNldF9iaXQoWkxPT1BfWk9ORV9TRVFfRVJST1IsICZ6b25lLT5mbGFn
cyk7CisJCXJldCA9IC1FSU87CisJCWdvdG8gdW5sb2NrOworCX0KKworCXpvbmUtPmNvbmQg
PSBCTEtfWk9ORV9DT05EX0ZVTEw7CisJem9uZS0+d3AgPSB6b25lLT5zdGFydCArIHpsby0+
em9uZV9zaXplOworCWNsZWFyX2JpdChaTE9PUF9aT05FX1NFUV9FUlJPUiwgJnpvbmUtPmZs
YWdzKTsKKworIHVubG9jazoKKwltdXRleF91bmxvY2soJnpvbmUtPmxvY2spOworCisJcmV0
dXJuIHJldDsKK30KKworc3RhdGljIHZvaWQgemxvb3BfcHV0X2NtZChzdHJ1Y3Qgemxvb3Bf
Y21kICpjbWQpCit7CisJc3RydWN0IHJlcXVlc3QgKnJxID0gYmxrX21xX3JxX2Zyb21fcGR1
KGNtZCk7CisKKwlpZiAoIWF0b21pY19kZWNfYW5kX3Rlc3QoJmNtZC0+cmVmKSkKKwkJcmV0
dXJuOworCWtmcmVlKGNtZC0+YnZlYyk7CisJY21kLT5idmVjID0gTlVMTDsKKwlpZiAobGlr
ZWx5KCFibGtfc2hvdWxkX2Zha2VfdGltZW91dChycS0+cSkpKQorCQlibGtfbXFfY29tcGxl
dGVfcmVxdWVzdChycSk7Cit9CisKK3N0YXRpYyB2b2lkIHpsb29wX3J3X2NvbXBsZXRlKHN0
cnVjdCBraW9jYiAqaW9jYiwgbG9uZyByZXQpCit7CisJc3RydWN0IHpsb29wX2NtZCAqY21k
ID0gY29udGFpbmVyX29mKGlvY2IsIHN0cnVjdCB6bG9vcF9jbWQsIGlvY2IpOworCisJY21k
LT5yZXQgPSByZXQ7CisJemxvb3BfcHV0X2NtZChjbWQpOworfQorCitzdGF0aWMgdm9pZCB6
bG9vcF9ydyhzdHJ1Y3Qgemxvb3BfY21kICpjbWQpCit7CisJc3RydWN0IHJlcXVlc3QgKnJx
ID0gYmxrX21xX3JxX2Zyb21fcGR1KGNtZCk7CisJc3RydWN0IHpsb29wX2RldmljZSAqemxv
ID0gcnEtPnEtPnF1ZXVlZGF0YTsKKwl1bnNpZ25lZCBpbnQgem9uZV9ubyA9IHJxX3pvbmVf
bm8ocnEpOworCXNlY3Rvcl90IHNlY3RvciA9IGJsa19ycV9wb3MocnEpOworCXNlY3Rvcl90
IG5yX3NlY3RvcnMgPSBibGtfcnFfc2VjdG9ycyhycSk7CisJYm9vbCBpc19hcHBlbmQgPSBy
ZXFfb3AocnEpID09IFJFUV9PUF9aT05FX0FQUEVORDsKKwlib29sIGlzX3dyaXRlID0gcmVx
X29wKHJxKSA9PSBSRVFfT1BfV1JJVEUgfHwgaXNfYXBwZW5kOworCWludCBydyA9IGlzX3dy
aXRlID8gSVRFUl9TT1VSQ0UgOiBJVEVSX0RFU1Q7CisJc3RydWN0IHJlcV9pdGVyYXRvciBy
cV9pdGVyOworCXN0cnVjdCB6bG9vcF96b25lICp6b25lOworCXN0cnVjdCBpb3ZfaXRlciBp
dGVyOworCXN0cnVjdCBiaW9fdmVjIHRtcDsKKwlzZWN0b3JfdCB6b25lX2VuZDsKKwlpbnQg
bnJfYnZlYyA9IDA7CisJaW50IHJldDsKKworCWF0b21pY19zZXQoJmNtZC0+cmVmLCAyKTsK
KwljbWQtPnNlY3RvciA9IHNlY3RvcjsKKwljbWQtPm5yX3NlY3RvcnMgPSBucl9zZWN0b3Jz
OworCWNtZC0+cmV0ID0gMDsKKworCS8qIFdlIHNob3VsZCBuZXZlciBnZXQgYW4gSS9PIGJl
eW9uZCB0aGUgZGV2aWNlIGNhcGFjaXR5LiAqLworCWlmIChXQVJOX09OX09OQ0Uoem9uZV9u
byA+PSB6bG8tPm5yX3pvbmVzKSkgeworCQlyZXQgPSAtRUlPOworCQlnb3RvIG91dDsKKwl9
CisJem9uZSA9ICZ6bG8tPnpvbmVzW3pvbmVfbm9dOworCXpvbmVfZW5kID0gem9uZS0+c3Rh
cnQgKyB6bG8tPnpvbmVfY2FwYWNpdHk7CisKKwkvKgorCSAqIFRoZSBibG9jayBsYXllciBz
aG91bGQgbmV2ZXIgc2VuZCByZXF1ZXN0cyB0aGF0IGFyZSBub3QgZnVsbHkKKwkgKiBjb250
YWluZWQgd2l0aGluIHRoZSB6b25lLgorCSAqLworCWlmIChXQVJOX09OX09OQ0Uoc2VjdG9y
ICsgbnJfc2VjdG9ycyA+IHpvbmUtPnN0YXJ0ICsgemxvLT56b25lX3NpemUpKSB7CisJCXJl
dCA9IC1FSU87CisJCWdvdG8gb3V0OworCX0KKworCWlmICh0ZXN0X2FuZF9jbGVhcl9iaXQo
WkxPT1BfWk9ORV9TRVFfRVJST1IsICZ6b25lLT5mbGFncykpIHsKKwkJbXV0ZXhfbG9jaygm
em9uZS0+bG9jayk7CisJCXJldCA9IHpsb29wX3VwZGF0ZV9zZXFfem9uZSh6bG8sIHpvbmVf
bm8pOworCQltdXRleF91bmxvY2soJnpvbmUtPmxvY2spOworCQlpZiAocmV0KQorCQkJZ290
byBvdXQ7CisJfQorCisJaWYgKCF0ZXN0X2JpdChaTE9PUF9aT05FX0NPTlYsICZ6b25lLT5m
bGFncykgJiYgaXNfd3JpdGUpIHsKKwkJbXV0ZXhfbG9jaygmem9uZS0+bG9jayk7CisKKwkJ
aWYgKGlzX2FwcGVuZCkgeworCQkJc2VjdG9yID0gem9uZS0+d3A7CisJCQljbWQtPnNlY3Rv
ciA9IHNlY3RvcjsKKwkJfQorCisJCS8qCisJCSAqIFdyaXRlIG9wZXJhdGlvbnMgbXVzdCBi
ZSBhbGlnbmVkIHRvIHRoZSB3cml0ZSBwb2ludGVyIGFuZAorCQkgKiBmdWxseSBjb250YWlu
ZWQgd2l0aGluIHRoZSB6b25lIGNhcGFjaXR5LgorCQkgKi8KKwkJaWYgKHNlY3RvciAhPSB6
b25lLT53cCB8fCB6b25lLT53cCArIG5yX3NlY3RvcnMgPiB6b25lX2VuZCkgeworCQkJcHJf
ZXJyKCJab25lICV1OiB1bmFsaWduZWQgd3JpdGU6IHNlY3QgJWxsdSwgd3AgJWxsdVxuIiwK
KwkJCSAgICAgICB6b25lX25vLCBzZWN0b3IsIHpvbmUtPndwKTsKKwkJCXJldCA9IC1FSU87
CisJCQlnb3RvIHVubG9jazsKKwkJfQorCisJCS8qIEltcGxpY2l0bHkgb3BlbiB0aGUgdGFy
Z2V0IHpvbmUuICovCisJCWlmICh6b25lLT5jb25kID09IEJMS19aT05FX0NPTkRfQ0xPU0VE
IHx8CisJCSAgICB6b25lLT5jb25kID09IEJMS19aT05FX0NPTkRfRU1QVFkpCisJCQl6b25l
LT5jb25kID0gQkxLX1pPTkVfQ09ORF9JTVBfT1BFTjsKKworCQkvKgorCQkgKiBBZHZhbmNl
IHRoZSB3cml0ZSBwb2ludGVyIG9mIHNlcXVlbnRpYWwgem9uZXMuIElmIHRoZSB3cml0ZQor
CQkgKiBmYWlscywgdGhlIHdwIHBvc2l0aW9uIHdpbGwgYmUgY29ycmVjdGVkIHdoZW4gdGhl
IG5leHQgSS9PCisJCSAqIGNvcG1wbGV0ZXMuCisJCSAqLworCQl6b25lLT53cCArPSBucl9z
ZWN0b3JzOworCQlpZiAoem9uZS0+d3AgPT0gem9uZV9lbmQpCisJCQl6b25lLT5jb25kID0g
QkxLX1pPTkVfQ09ORF9GVUxMOworCX0KKworCXJxX2Zvcl9lYWNoX2J2ZWModG1wLCBycSwg
cnFfaXRlcikKKwkJbnJfYnZlYysrOworCisJaWYgKHJxLT5iaW8gIT0gcnEtPmJpb3RhaWwp
IHsKKwkJc3RydWN0IGJpb192ZWMgKmJ2ZWM7CisKKwkJY21kLT5idmVjID0ga21hbGxvY19h
cnJheShucl9idmVjLCBzaXplb2YoKmNtZC0+YnZlYyksIEdGUF9OT0lPKTsKKwkJaWYgKCFj
bWQtPmJ2ZWMpIHsKKwkJCXJldCA9IC1FSU87CisJCQlnb3RvIHVubG9jazsKKwkJfQorCisJ
CS8qCisJCSAqIFRoZSBiaW9zIG9mIHRoZSByZXF1ZXN0IG1heSBiZSBzdGFydGVkIGZyb20g
dGhlIG1pZGRsZSBvZgorCQkgKiB0aGUgJ2J2ZWMnIGJlY2F1c2Ugb2YgYmlvIHNwbGl0dGlu
Zywgc28gd2UgY2FuJ3QgZGlyZWN0bHkKKwkJICogY29weSBiaW8tPmJpX2lvdl92ZWMgdG8g
bmV3IGJ2ZWMuIFRoZSBycV9mb3JfZWFjaF9idmVjCisJCSAqIEFQSSB3aWxsIHRha2UgY2Fy
ZSBvZiBhbGwgZGV0YWlscyBmb3IgdXMuCisJCSAqLworCQlidmVjID0gY21kLT5idmVjOwor
CQlycV9mb3JfZWFjaF9idmVjKHRtcCwgcnEsIHJxX2l0ZXIpIHsKKwkJCSpidmVjID0gdG1w
OworCQkJYnZlYysrOworCQl9CisJCWlvdl9pdGVyX2J2ZWMoJml0ZXIsIHJ3LCBjbWQtPmJ2
ZWMsIG5yX2J2ZWMsIGJsa19ycV9ieXRlcyhycSkpOworCX0gZWxzZSB7CisJCS8qCisJCSAq
IFNhbWUgaGVyZSwgdGhpcyBiaW8gbWF5IGJlIHN0YXJ0ZWQgZnJvbSB0aGUgbWlkZGxlIG9m
IHRoZQorCQkgKiAnYnZlYycgYmVjYXVzZSBvZiBiaW8gc3BsaXR0aW5nLCBzbyBvZmZzZXQg
ZnJvbSB0aGUgYnZlYworCQkgKiBtdXN0IGJlIHBhc3NlZCB0byBpb3YgaXRlcmF0b3IKKwkJ
ICovCisJCWlvdl9pdGVyX2J2ZWMoJml0ZXIsIHJ3LAorCQkJX19idmVjX2l0ZXJfYnZlYyhy
cS0+YmlvLT5iaV9pb192ZWMsIHJxLT5iaW8tPmJpX2l0ZXIpLAorCQkJCQlucl9idmVjLCBi
bGtfcnFfYnl0ZXMocnEpKTsKKwkJaXRlci5pb3Zfb2Zmc2V0ID0gcnEtPmJpby0+YmlfaXRl
ci5iaV9idmVjX2RvbmU7CisJfQorCisJY21kLT5pb2NiLmtpX3BvcyA9IChzZWN0b3IgLSB6
b25lLT5zdGFydCkgPDwgU0VDVE9SX1NISUZUOworCWNtZC0+aW9jYi5raV9maWxwID0gem9u
ZS0+ZmlsZTsKKwljbWQtPmlvY2Iua2lfY29tcGxldGUgPSB6bG9vcF9yd19jb21wbGV0ZTsK
KwlpZiAoIXpsby0+YnVmZmVyZWRfaW8pCisJCWNtZC0+aW9jYi5raV9mbGFncyA9IElPQ0Jf
RElSRUNUOworCWNtZC0+aW9jYi5raV9pb3ByaW8gPSBJT1BSSU9fUFJJT19WQUxVRShJT1BS
SU9fQ0xBU1NfTk9ORSwgMCk7CisKKwlpZiAocncgPT0gSVRFUl9TT1VSQ0UpCisJCXJldCA9
IHpvbmUtPmZpbGUtPmZfb3AtPndyaXRlX2l0ZXIoJmNtZC0+aW9jYiwgJml0ZXIpOworCWVs
c2UKKwkJcmV0ID0gem9uZS0+ZmlsZS0+Zl9vcC0+cmVhZF9pdGVyKCZjbWQtPmlvY2IsICZp
dGVyKTsKK3VubG9jazoKKwlpZiAoIXRlc3RfYml0KFpMT09QX1pPTkVfQ09OViwgJnpvbmUt
PmZsYWdzKSAmJiBpc193cml0ZSkKKwkJbXV0ZXhfdW5sb2NrKCZ6b25lLT5sb2NrKTsKK291
dDoKKwlpZiAocmV0ICE9IC1FSU9DQlFVRVVFRCkKKwkJemxvb3BfcndfY29tcGxldGUoJmNt
ZC0+aW9jYiwgcmV0KTsKKwl6bG9vcF9wdXRfY21kKGNtZCk7Cit9CisKK3N0YXRpYyB2b2lk
IHpsb29wX2hhbmRsZV9jbWQoc3RydWN0IHpsb29wX2NtZCAqY21kKQoreworCXN0cnVjdCBy
ZXF1ZXN0ICpycSA9IGJsa19tcV9ycV9mcm9tX3BkdShjbWQpOworCXN0cnVjdCB6bG9vcF9k
ZXZpY2UgKnpsbyA9IHJxLT5xLT5xdWV1ZWRhdGE7CisKKwlzd2l0Y2ggKHJlcV9vcChycSkp
IHsKKwljYXNlIFJFUV9PUF9SRUFEOgorCWNhc2UgUkVRX09QX1dSSVRFOgorCWNhc2UgUkVR
X09QX1pPTkVfQVBQRU5EOgorCQkvKgorCQkgKiB6bG9vcF9ydygpIGFsd2F5cyBleGVjdXRl
cyBhc3luY2hyb25vdXNseSBvciBjb21wbGV0ZXMKKwkJICogZGlyZWN0bHkuCisJCSAqLwor
CQl6bG9vcF9ydyhjbWQpOworCQlyZXR1cm47CisJY2FzZSBSRVFfT1BfRkxVU0g6CisJCS8q
CisJCSAqIFN5bmMgdGhlIGVudGlyZSBGUyBjb250YWluaW5nIHRoZSB6b25lIGZpbGVzIGlu
c3RlYWQgb2YKKwkJICogd2Fsa2luZyBhbGwgZmlsZXMKKwkJICovCisJCWNtZC0+cmV0ID0g
c3luY19maWxlc3lzdGVtKGZpbGVfaW5vZGUoemxvLT5kYXRhX2RpciktPmlfc2IpOworCQli
cmVhazsKKwljYXNlIFJFUV9PUF9aT05FX1JFU0VUOgorCQljbWQtPnJldCA9IHpsb29wX3Jl
c2V0X3pvbmUoemxvLCBycV96b25lX25vKHJxKSk7CisJCWJyZWFrOworCWNhc2UgUkVRX09Q
X1pPTkVfUkVTRVRfQUxMOgorCQljbWQtPnJldCA9IHpsb29wX3Jlc2V0X2FsbF96b25lcyh6
bG8pOworCQlicmVhazsKKwljYXNlIFJFUV9PUF9aT05FX0ZJTklTSDoKKwkJY21kLT5yZXQg
PSB6bG9vcF9maW5pc2hfem9uZSh6bG8sIHJxX3pvbmVfbm8ocnEpKTsKKwkJYnJlYWs7CisJ
Y2FzZSBSRVFfT1BfWk9ORV9PUEVOOgorCQljbWQtPnJldCA9IHpsb29wX29wZW5fem9uZSh6
bG8sIHJxX3pvbmVfbm8ocnEpKTsKKwkJYnJlYWs7CisJY2FzZSBSRVFfT1BfWk9ORV9DTE9T
RToKKwkJY21kLT5yZXQgPSB6bG9vcF9jbG9zZV96b25lKHpsbywgcnFfem9uZV9ubyhycSkp
OworCQlicmVhazsKKwlkZWZhdWx0OgorCQlXQVJOX09OX09OQ0UoMSk7CisJCXByX2Vycigi
VW5zdXBwb3J0ZWQgb3BlcmF0aW9uICVkXG4iLCByZXFfb3AocnEpKTsKKwkJY21kLT5yZXQg
PSAtRU9QTk9UU1VQUDsKKwkJYnJlYWs7CisJfQorCisJYmxrX21xX2NvbXBsZXRlX3JlcXVl
c3QocnEpOworfQorCitzdGF0aWMgdm9pZCB6bG9vcF9jbWRfd29ya2ZuKHN0cnVjdCB3b3Jr
X3N0cnVjdCAqd29yaykKK3sKKwlzdHJ1Y3Qgemxvb3BfY21kICpjbWQgPSBjb250YWluZXJf
b2Yod29yaywgc3RydWN0IHpsb29wX2NtZCwgd29yayk7CisJaW50IG9yaWdfZmxhZ3MgPSBj
dXJyZW50LT5mbGFnczsKKworCWN1cnJlbnQtPmZsYWdzIHw9IFBGX0xPQ0FMX1RIUk9UVExF
IHwgUEZfTUVNQUxMT0NfTk9JTzsKKwl6bG9vcF9oYW5kbGVfY21kKGNtZCk7CisJY3VycmVu
dC0+ZmxhZ3MgPSBvcmlnX2ZsYWdzOworfQorCitzdGF0aWMgdm9pZCB6bG9vcF9jb21wbGV0
ZV9ycShzdHJ1Y3QgcmVxdWVzdCAqcnEpCit7CisJc3RydWN0IHpsb29wX2NtZCAqY21kID0g
YmxrX21xX3JxX3RvX3BkdShycSk7CisJc3RydWN0IHpsb29wX2RldmljZSAqemxvID0gcnEt
PnEtPnF1ZXVlZGF0YTsKKwl1bnNpZ25lZCBpbnQgem9uZV9ubyA9IGNtZC0+c2VjdG9yID4+
IHpsby0+em9uZV9zaGlmdDsKKwlzdHJ1Y3Qgemxvb3Bfem9uZSAqem9uZSA9ICZ6bG8tPnpv
bmVzW3pvbmVfbm9dOworCWJsa19zdGF0dXNfdCBzdHMgPSBCTEtfU1RTX09LOworCisJc3dp
dGNoIChyZXFfb3AocnEpKSB7CisJY2FzZSBSRVFfT1BfUkVBRDoKKwkJaWYgKGNtZC0+cmV0
IDwgMCkKKwkJCXByX2VycigiWm9uZSAldTogZmFpbGVkIHJlYWQgc2VjdG9yICVsbHUsICVs
bHUgc2VjdG9yc1xuIiwKKwkJCSAgICAgICB6b25lX25vLCBjbWQtPnNlY3RvciwgY21kLT5u
cl9zZWN0b3JzKTsKKworCQlpZiAoY21kLT5yZXQgPj0gMCAmJiBjbWQtPnJldCAhPSBibGtf
cnFfYnl0ZXMocnEpKSB7CisJCQkvKiBzaG9ydCByZWFkICovCisJCQlzdHJ1Y3QgYmlvICpi
aW87CisKKwkJCV9fcnFfZm9yX2VhY2hfYmlvKGJpbywgcnEpCisJCQkJemVyb19maWxsX2Jp
byhiaW8pOworCQl9CisJCWJyZWFrOworCWNhc2UgUkVRX09QX1dSSVRFOgorCWNhc2UgUkVR
X09QX1pPTkVfQVBQRU5EOgorCQlpZiAoY21kLT5yZXQgPCAwKQorCQkJcHJfZXJyKCJab25l
ICV1OiBmYWlsZWQgJXN3cml0ZSBzZWN0b3IgJWxsdSwgJWxsdSBzZWN0b3JzXG4iLAorCQkJ
ICAgICAgIHpvbmVfbm8sCisJCQkgICAgICAgcmVxX29wKHJxKSA9PSBSRVFfT1BfV1JJVEUg
PyAiIiA6ICJhcHBlbmQgIiwKKwkJCSAgICAgICBjbWQtPnNlY3RvciwgY21kLT5ucl9zZWN0
b3JzKTsKKworCQlpZiAoY21kLT5yZXQgPj0gMCAmJiBjbWQtPnJldCAhPSBibGtfcnFfYnl0
ZXMocnEpKSB7CisJCQlwcl9lcnIoIlpvbmUgJXU6IHBhcnRpYWwgd3JpdGUgJWxkLyV1IEJc
biIsCisJCQkgICAgICAgem9uZV9ubywgY21kLT5yZXQsIGJsa19ycV9ieXRlcyhycSkpOwor
CQkJY21kLT5yZXQgPSAtRUlPOworCQl9CisKKwkJaWYgKGNtZC0+cmV0IDwgMCAmJiAhdGVz
dF9iaXQoWkxPT1BfWk9ORV9DT05WLCAmem9uZS0+ZmxhZ3MpKSB7CisJCQkvKgorCQkJICog
QSB3cml0ZSB0byBhIHNlcXVlbnRpYWwgem9uZSBmaWxlIGZhaWxlZDogbWFyayB0aGUKKwkJ
CSAqIHpvbmUgYXMgaGF2aW5nIGFuIGVycm9yLiBUaGlzIHdpbGwgYmUgY29ycmVjdGVkIGFu
ZAorCQkJICogY2xlYXJlZCB3aGVuIHRoZSBuZXh0IElPIGlzIHN1Ym1pdHRlZC4KKwkJCSAq
LworCQkJc2V0X2JpdChaTE9PUF9aT05FX1NFUV9FUlJPUiwgJnpvbmUtPmZsYWdzKTsKKwkJ
CWJyZWFrOworCQl9CisJCWlmIChyZXFfb3AocnEpID09IFJFUV9PUF9aT05FX0FQUEVORCkK
KwkJCXJxLT5fX3NlY3RvciA9IGNtZC0+c2VjdG9yOworCisJCWJyZWFrOworCWRlZmF1bHQ6
CisJCWJyZWFrOworCX0KKworCWlmIChjbWQtPnJldCA8IDApCisJCXN0cyA9IGVycm5vX3Rv
X2Jsa19zdGF0dXMoY21kLT5yZXQpOworCWJsa19tcV9lbmRfcmVxdWVzdChycSwgc3RzKTsK
K30KKworc3RhdGljIGJsa19zdGF0dXNfdCB6bG9vcF9xdWV1ZV9ycShzdHJ1Y3QgYmxrX21x
X2h3X2N0eCAqaGN0eCwKKwkJCQkgICBjb25zdCBzdHJ1Y3QgYmxrX21xX3F1ZXVlX2RhdGEg
KmJkKQoreworCXN0cnVjdCByZXF1ZXN0ICpycSA9IGJkLT5ycTsKKwlzdHJ1Y3Qgemxvb3Bf
Y21kICpjbWQgPSBibGtfbXFfcnFfdG9fcGR1KHJxKTsKKwlzdHJ1Y3Qgemxvb3BfZGV2aWNl
ICp6bG8gPSBycS0+cS0+cXVldWVkYXRhOworCisJaWYgKHpsby0+c3RhdGUgPT0gWmxvX2Rl
bGV0aW5nKQorCQlyZXR1cm4gQkxLX1NUU19JT0VSUjsKKworCWJsa19tcV9zdGFydF9yZXF1
ZXN0KHJxKTsKKworCUlOSVRfV09SSygmY21kLT53b3JrLCB6bG9vcF9jbWRfd29ya2ZuKTsK
KwlxdWV1ZV93b3JrKHpsby0+d29ya3F1ZXVlLCAmY21kLT53b3JrKTsKKworCXJldHVybiBC
TEtfU1RTX09LOworfQorCitzdGF0aWMgY29uc3Qgc3RydWN0IGJsa19tcV9vcHMgemxvb3Bf
bXFfb3BzID0geworCS5xdWV1ZV9ycSAgICAgICA9IHpsb29wX3F1ZXVlX3JxLAorCS5jb21w
bGV0ZQk9IHpsb29wX2NvbXBsZXRlX3JxLAorfTsKKworc3RhdGljIGludCB6bG9vcF9vcGVu
KHN0cnVjdCBnZW5kaXNrICpkaXNrLCBibGtfbW9kZV90IG1vZGUpCit7CisJc3RydWN0IHps
b29wX2RldmljZSAqemxvID0gZGlzay0+cHJpdmF0ZV9kYXRhOworCWludCByZXQ7CisKKwly
ZXQgPSBtdXRleF9sb2NrX2tpbGxhYmxlKCZ6bG9vcF9jdGxfbXV0ZXgpOworCWlmIChyZXQp
CisJCXJldHVybiByZXQ7CisKKwlpZiAoemxvLT5zdGF0ZSAhPSBabG9fbGl2ZSkKKwkJcmV0
ID0gLUVOWElPOworCW11dGV4X3VubG9jaygmemxvb3BfY3RsX211dGV4KTsKKwlyZXR1cm4g
cmV0OworfQorCitzdGF0aWMgaW50IHpsb29wX3JlcG9ydF96b25lcyhzdHJ1Y3QgZ2VuZGlz
ayAqZGlzaywgc2VjdG9yX3Qgc2VjdG9yLAorCQl1bnNpZ25lZCBpbnQgbnJfem9uZXMsIHJl
cG9ydF96b25lc19jYiBjYiwgdm9pZCAqZGF0YSkKK3sKKwlzdHJ1Y3Qgemxvb3BfZGV2aWNl
ICp6bG8gPSBkaXNrLT5wcml2YXRlX2RhdGE7CisJc3RydWN0IGJsa196b25lIGJsa3ogPSB7
fTsKKwl1bnNpZ25lZCBpbnQgZmlyc3QsIGk7CisJaW50IHJldDsKKworCWZpcnN0ID0gZGlz
a196b25lX25vKGRpc2ssIHNlY3Rvcik7CisJaWYgKGZpcnN0ID49IHpsby0+bnJfem9uZXMp
CisJCXJldHVybiAwOworCW5yX3pvbmVzID0gbWluKG5yX3pvbmVzLCB6bG8tPm5yX3pvbmVz
IC0gZmlyc3QpOworCisJZm9yIChpID0gMDsgaSA8IG5yX3pvbmVzOyBpKyspIHsKKwkJdW5z
aWduZWQgaW50IHpvbmVfbm8gPSBmaXJzdCArIGk7CisJCXN0cnVjdCB6bG9vcF96b25lICp6
b25lID0gJnpsby0+em9uZXNbem9uZV9ub107CisKKwkJbXV0ZXhfbG9jaygmem9uZS0+bG9j
ayk7CisKKwkJaWYgKHRlc3RfYW5kX2NsZWFyX2JpdChaTE9PUF9aT05FX1NFUV9FUlJPUiwg
JnpvbmUtPmZsYWdzKSkgeworCQkJcmV0ID0gemxvb3BfdXBkYXRlX3NlcV96b25lKHpsbywg
em9uZV9ubyk7CisJCQlpZiAocmV0KSB7CisJCQkJbXV0ZXhfdW5sb2NrKCZ6b25lLT5sb2Nr
KTsKKwkJCQlyZXR1cm4gcmV0OworCQkJfQorCQl9CisKKwkJYmxrei5zdGFydCA9IHpvbmUt
PnN0YXJ0OworCQlibGt6LmxlbiA9IHpsby0+em9uZV9zaXplOworCQlibGt6LndwID0gem9u
ZS0+d3A7CisJCWJsa3ouY29uZCA9IHpvbmUtPmNvbmQ7CisJCWlmICh0ZXN0X2JpdChaTE9P
UF9aT05FX0NPTlYsICZ6b25lLT5mbGFncykpIHsKKwkJCWJsa3oudHlwZSA9IEJMS19aT05F
X1RZUEVfQ09OVkVOVElPTkFMOworCQkJYmxrei5jYXBhY2l0eSA9IHpsby0+em9uZV9zaXpl
OworCQl9IGVsc2UgeworCQkJYmxrei50eXBlID0gQkxLX1pPTkVfVFlQRV9TRVFXUklURV9S
RVE7CisJCQlibGt6LmNhcGFjaXR5ID0gemxvLT56b25lX2NhcGFjaXR5OworCQl9CisKKwkJ
bXV0ZXhfdW5sb2NrKCZ6b25lLT5sb2NrKTsKKworCQlyZXQgPSBjYigmYmxreiwgaSwgZGF0
YSk7CisJCWlmIChyZXQpCisJCQlyZXR1cm4gcmV0OworCX0KKworCXJldHVybiBucl96b25l
czsKK30KKworc3RhdGljIHZvaWQgemxvb3BfZnJlZV9kaXNrKHN0cnVjdCBnZW5kaXNrICpk
aXNrKQoreworCXN0cnVjdCB6bG9vcF9kZXZpY2UgKnpsbyA9IGRpc2stPnByaXZhdGVfZGF0
YTsKKwl1bnNpZ25lZCBpbnQgaTsKKworCWZvciAoaSA9IDA7IGkgPCB6bG8tPm5yX3pvbmVz
OyBpKyspIHsKKwkJc3RydWN0IHpsb29wX3pvbmUgKnpvbmUgPSAmemxvLT56b25lc1tpXTsK
KworCQltYXBwaW5nX3NldF9nZnBfbWFzayh6b25lLT5maWxlLT5mX21hcHBpbmcsCisJCQkJ
em9uZS0+b2xkX2dmcF9tYXNrKTsKKwkJZnB1dCh6b25lLT5maWxlKTsKKwl9CisKKwlmcHV0
KHpsby0+ZGF0YV9kaXIpOworCWRlc3Ryb3lfd29ya3F1ZXVlKHpsby0+d29ya3F1ZXVlKTsK
KwlrZnJlZSh6bG8tPmJhc2VfZGlyKTsKKwlrdmZyZWUoemxvKTsKK30KKworc3RhdGljIGNv
bnN0IHN0cnVjdCBibG9ja19kZXZpY2Vfb3BlcmF0aW9ucyB6bG9vcF9mb3BzID0geworCS5v
d25lcgkJCT0gVEhJU19NT0RVTEUsCisJLm9wZW4JCQk9IHpsb29wX29wZW4sCisJLnJlcG9y
dF96b25lcwkJPSB6bG9vcF9yZXBvcnRfem9uZXMsCisJLmZyZWVfZGlzawkJPSB6bG9vcF9m
cmVlX2Rpc2ssCit9OworCitfX3ByaW50ZigzLCA0KQorc3RhdGljIHN0cnVjdCBmaWxlICp6
bG9vcF9maWxwX29wZW5fZm10KGludCBvZmxhZ3MsIHVtb2RlX3QgbW9kZSwKKwkJY29uc3Qg
Y2hhciAqZm10LCAuLi4pCit7CisJc3RydWN0IGZpbGUgKmZpbGU7CisJdmFfbGlzdCBhcDsK
KwljaGFyICpwOworCisJdmFfc3RhcnQoYXAsIGZtdCk7CisJcCA9IGt2YXNwcmludGYoR0ZQ
X0tFUk5FTCwgZm10LCBhcCk7CisJdmFfZW5kKGFwKTsKKworCWlmICghcCkKKwkJcmV0dXJu
IEVSUl9QVFIoLUVOT01FTSk7CisJZmlsZSA9IGZpbHBfb3BlbihwLCBvZmxhZ3MsIG1vZGUp
OworCWtmcmVlKHApOworCXJldHVybiBmaWxlOworfQorCitzdGF0aWMgaW50IHpsb29wX2lu
aXRfem9uZShzdHJ1Y3Qgemxvb3BfZGV2aWNlICp6bG8sIHVuc2lnbmVkIGludCB6b25lX25v
LAorCQkJICAgc3RydWN0IHpsb29wX29wdGlvbnMgKm9wdHMsIGJvb2wgcmVzdG9yZSkKK3sK
KwlzdHJ1Y3Qgemxvb3Bfem9uZSAqem9uZSA9ICZ6bG8tPnpvbmVzW3pvbmVfbm9dOworCWlu
dCBvZmxhZ3MgPSBPX1JEV1I7CisJc3RydWN0IGtzdGF0IHN0YXQ7CisJc2VjdG9yX3QgZmls
ZV9zZWN0b3JzOworCWludCByZXQ7CisKKwltdXRleF9pbml0KCZ6b25lLT5sb2NrKTsKKwl6
b25lLT5zdGFydCA9IChzZWN0b3JfdCl6b25lX25vIDw8IHpsby0+em9uZV9zaGlmdDsKKwor
CWlmICghcmVzdG9yZSkKKwkJb2ZsYWdzIHw9IE9fQ1JFQVQ7CisKKwlpZiAoIW9wdHMtPmJ1
ZmZlcmVkX2lvKQorCQlvZmxhZ3MgfD0gT19ESVJFQ1Q7CisKKwlpZiAoem9uZV9ubyA8IHps
by0+bnJfY29udl96b25lcykgeworCQkvKiBDb252ZW50aW9uYWwgem9uZSBmaWxlLiAqLwor
CQlzZXRfYml0KFpMT09QX1pPTkVfQ09OViwgJnpvbmUtPmZsYWdzKTsKKwkJem9uZS0+Y29u
ZCA9IEJMS19aT05FX0NPTkRfTk9UX1dQOworCQl6b25lLT53cCA9IFU2NF9NQVg7CisKKwkJ
em9uZS0+ZmlsZSA9IHpsb29wX2ZpbHBfb3Blbl9mbXQob2ZsYWdzLCAwNjAwLCAiJXMvJXUv
Y252LSUwNnUiLAorCQkJCQl6bG8tPmJhc2VfZGlyLCB6bG8tPmlkLCB6b25lX25vKTsKKwkJ
aWYgKElTX0VSUih6b25lLT5maWxlKSkgeworCQkJcHJfZXJyKCJGYWlsZWQgdG8gb3BlbiB6
b25lICV1IGZpbGUgJXMvJXUvY252LSUwNnUgKGVycj0lbGQpIiwKKwkJCSAgICAgICB6b25l
X25vLCB6bG8tPmJhc2VfZGlyLCB6bG8tPmlkLCB6b25lX25vLAorCQkJICAgICAgIFBUUl9F
UlIoem9uZS0+ZmlsZSkpOworCQkJcmV0dXJuIFBUUl9FUlIoem9uZS0+ZmlsZSk7CisJCX0K
KworCQlyZXQgPSB2ZnNfZ2V0YXR0cigmem9uZS0+ZmlsZS0+Zl9wYXRoLCAmc3RhdCwgU1RB
VFhfU0laRSwgMCk7CisJCWlmIChyZXQgPCAwKSB7CisJCQlwcl9lcnIoIkZhaWxlZCB0byBn
ZXQgem9uZSAldSBmaWxlIHN0YXRcbiIsIHpvbmVfbm8pOworCQkJcmV0dXJuIHJldDsKKwkJ
fQorCQlmaWxlX3NlY3RvcnMgPSBzdGF0LnNpemUgPj4gU0VDVE9SX1NISUZUOworCisJCWlm
IChyZXN0b3JlICYmIGZpbGVfc2VjdG9ycyAhPSB6bG8tPnpvbmVfc2l6ZSkgeworCQkJcHJf
ZXJyKCJJbnZhbGlkIGNvbnZlbnRpb25hbCB6b25lICV1IGZpbGUgc2l6ZSAoJWxsdSBzZWN0
b3JzICE9ICVsbHUpXG4iLAorCQkJICAgICAgIHpvbmVfbm8sIGZpbGVfc2VjdG9ycywgemxv
LT56b25lX2NhcGFjaXR5KTsKKwkJCXJldHVybiByZXQ7CisJCX0KKworCQlyZXQgPSB2ZnNf
dHJ1bmNhdGUoJnpvbmUtPmZpbGUtPmZfcGF0aCwKKwkJCQkgICB6bG8tPnpvbmVfc2l6ZSA8
PCBTRUNUT1JfU0hJRlQpOworCQlpZiAocmV0IDwgMCkgeworCQkJcHJfZXJyKCJGYWlsZWQg
dG8gdHJ1bmNhdGUgem9uZSAldSBmaWxlIChlcnI9JWQpXG4iLAorCQkJICAgICAgIHpvbmVf
bm8sIHJldCk7CisJCQlyZXR1cm4gcmV0OworCQl9CisKKwkJcmV0dXJuIDA7CisJfQorCisJ
LyogU2VxdWVudGlhbCB6b25lIGZpbGUuICovCisJem9uZS0+ZmlsZSA9IHpsb29wX2ZpbHBf
b3Blbl9mbXQob2ZsYWdzLCAwNjAwLCAiJXMvJXUvc2VxLSUwNnUiLAorCQkJCQkgemxvLT5i
YXNlX2RpciwgemxvLT5pZCwgem9uZV9ubyk7CisJaWYgKElTX0VSUih6b25lLT5maWxlKSkg
eworCQlwcl9lcnIoIkZhaWxlZCB0byBvcGVuIHpvbmUgJXUgZmlsZSAlcy8ldS9zZXEtJTA2
dSAoZXJyPSVsZCkiLAorCQkgICAgICAgem9uZV9ubywgemxvLT5iYXNlX2RpciwgemxvLT5p
ZCwgem9uZV9ubywKKwkJICAgICAgIFBUUl9FUlIoem9uZS0+ZmlsZSkpOworCQlyZXR1cm4g
UFRSX0VSUih6b25lLT5maWxlKTsKKwl9CisKKwltdXRleF9sb2NrKCZ6b25lLT5sb2NrKTsK
KwlyZXQgPSB6bG9vcF91cGRhdGVfc2VxX3pvbmUoemxvLCB6b25lX25vKTsKKwltdXRleF91
bmxvY2soJnpvbmUtPmxvY2spOworCisJcmV0dXJuIHJldDsKK30KKworc3RhdGljIGJvb2wg
emxvb3BfZGV2X2V4aXN0cyhzdHJ1Y3Qgemxvb3BfZGV2aWNlICp6bG8pCit7CisJc3RydWN0
IGZpbGUgKmNudiwgKnNlcTsKKwlib29sIGV4aXN0czsKKworCWNudiA9IHpsb29wX2ZpbHBf
b3Blbl9mbXQoT19SRE9OTFksIDA2MDAsICIlcy8ldS9jbnYtJTA2dSIsCisJCQkJICB6bG8t
PmJhc2VfZGlyLCB6bG8tPmlkLCAwKTsKKwlzZXEgPSB6bG9vcF9maWxwX29wZW5fZm10KE9f
UkRPTkxZLCAwNjAwLCAiJXMvJXUvc2VxLSUwNnUiLAorCQkJCSAgemxvLT5iYXNlX2Rpciwg
emxvLT5pZCwgMCk7CisJZXhpc3RzID0gIUlTX0VSUihjbnYpIHx8ICFJU19FUlIoc2VxKTsK
KworCWlmICghSVNfRVJSKGNudikpCisJCWZwdXQoY252KTsKKwlpZiAoIUlTX0VSUihzZXEp
KQorCQlmcHV0KHNlcSk7CisKKwlyZXR1cm4gZXhpc3RzOworfQorCitzdGF0aWMgaW50IHps
b29wX2N0bF9hZGQoc3RydWN0IHpsb29wX29wdGlvbnMgKm9wdHMpCit7CisJc3RydWN0IHF1
ZXVlX2xpbWl0cyBsaW0gPSB7CisJCS5tYXhfaHdfc2VjdG9ycwkJPSBTWl8xTSA+PiBTRUNU
T1JfU0hJRlQsCisJCS5tYXhfaHdfem9uZV9hcHBlbmRfc2VjdG9ycyA9IFNaXzFNID4+IFNF
Q1RPUl9TSElGVCwKKwkJLmNodW5rX3NlY3RvcnMJCT0gb3B0cy0+em9uZV9zaXplLAorCQku
ZmVhdHVyZXMJCT0gQkxLX0ZFQVRfWk9ORUQsCisJfTsKKwl1bnNpZ25lZCBpbnQgbnJfem9u
ZXMsIGksIGo7CisJc3RydWN0IHpsb29wX2RldmljZSAqemxvOworCWludCBibG9ja19zaXpl
OworCWludCByZXQgPSAtRUlOVkFMOworCWJvb2wgcmVzdG9yZTsKKworCV9fbW9kdWxlX2dl
dChUSElTX01PRFVMRSk7CisKKwlucl96b25lcyA9IG9wdHMtPmNhcGFjaXR5ID4+IGlsb2cy
KG9wdHMtPnpvbmVfc2l6ZSk7CisJaWYgKG9wdHMtPm5yX2NvbnZfem9uZXMgPj0gbnJfem9u
ZXMpIHsKKwkJcHJfZXJyKCJJbnZhbGlkIG51bWJlciBvZiBjb252ZW50aW9uYWwgem9uZXMg
JXVcbiIsCisJCSAgICAgICBvcHRzLT5ucl9jb252X3pvbmVzKTsKKwkJZ290byBvdXQ7CisJ
fQorCisJemxvID0ga3Z6YWxsb2Moc3RydWN0X3NpemUoemxvLCB6b25lcywgbnJfem9uZXMp
LCBHRlBfS0VSTkVMKTsKKwlpZiAoIXpsbykgeworCQlyZXQgPSAtRU5PTUVNOworCQlnb3Rv
IG91dDsKKwl9CisJemxvLT5zdGF0ZSA9IFpsb19jcmVhdGluZzsKKworCXJldCA9IG11dGV4
X2xvY2tfa2lsbGFibGUoJnpsb29wX2N0bF9tdXRleCk7CisJaWYgKHJldCkKKwkJZ290byBv
dXRfZnJlZV9kZXY7CisKKwkvKiBBbGxvY2F0ZSBpZCwgaWYgQG9wdHMtPmlkID49IDAsIHdl
J3JlIHJlcXVlc3RpbmcgdGhhdCBzcGVjaWZpYyBpZCAqLworCWlmIChvcHRzLT5pZCA+PSAw
KSB7CisJCXJldCA9IGlkcl9hbGxvYygmemxvb3BfaW5kZXhfaWRyLCB6bG8sCisJCQkJICBv
cHRzLT5pZCwgb3B0cy0+aWQgKyAxLCBHRlBfS0VSTkVMKTsKKwkJaWYgKHJldCA9PSAtRU5P
U1BDKQorCQkJcmV0ID0gLUVFWElTVDsKKwl9IGVsc2UgeworCQlyZXQgPSBpZHJfYWxsb2Mo
Jnpsb29wX2luZGV4X2lkciwgemxvLCAwLCAwLCBHRlBfS0VSTkVMKTsKKwl9CisJbXV0ZXhf
dW5sb2NrKCZ6bG9vcF9jdGxfbXV0ZXgpOworCWlmIChyZXQgPCAwKQorCQlnb3RvIG91dF9m
cmVlX2RldjsKKworCXpsby0+aWQgPSByZXQ7CisJemxvLT56b25lX3NoaWZ0ID0gaWxvZzIo
b3B0cy0+em9uZV9zaXplKTsKKwl6bG8tPnpvbmVfc2l6ZSA9IG9wdHMtPnpvbmVfc2l6ZTsK
KwlpZiAob3B0cy0+em9uZV9jYXBhY2l0eSkKKwkJemxvLT56b25lX2NhcGFjaXR5ID0gb3B0
cy0+em9uZV9jYXBhY2l0eTsKKwllbHNlCisJCXpsby0+em9uZV9jYXBhY2l0eSA9IHpsby0+
em9uZV9zaXplOworCXpsby0+bnJfem9uZXMgPSBucl96b25lczsKKwl6bG8tPm5yX2NvbnZf
em9uZXMgPSBvcHRzLT5ucl9jb252X3pvbmVzOworCXpsby0+YnVmZmVyZWRfaW8gPSBvcHRz
LT5idWZmZXJlZF9pbzsKKworCXpsby0+d29ya3F1ZXVlID0gYWxsb2Nfd29ya3F1ZXVlKCJ6
bG9vcCVkIiwgV1FfVU5CT1VORCB8IFdRX0ZSRUVaQUJMRSwKKwkJCQlvcHRzLT5ucl9xdWV1
ZXMgKiBvcHRzLT5xdWV1ZV9kZXB0aCwgemxvLT5pZCk7CisJaWYgKCF6bG8tPndvcmtxdWV1
ZSkgeworCQlyZXQgPSAtRU5PTUVNOworCQlnb3RvIG91dF9mcmVlX2lkcjsKKwl9CisKKwlp
ZiAob3B0cy0+YmFzZV9kaXIpCisJCXpsby0+YmFzZV9kaXIgPSBrc3RyZHVwKG9wdHMtPmJh
c2VfZGlyLCBHRlBfS0VSTkVMKTsKKwllbHNlCisJCXpsby0+YmFzZV9kaXIgPSBrc3RyZHVw
KFpMT09QX0RFRl9CQVNFX0RJUiwgR0ZQX0tFUk5FTCk7CisJaWYgKCF6bG8tPmJhc2VfZGly
KSB7CisJCXJldCA9IC1FTk9NRU07CisJCWdvdG8gb3V0X2Rlc3Ryb3lfd29ya3F1ZXVlOwor
CX0KKworCXpsby0+ZGF0YV9kaXIgPSB6bG9vcF9maWxwX29wZW5fZm10KE9fUkRPTkxZIHwg
T19ESVJFQ1RPUlksIDAsICIlcy8ldSIsCisJCQkJCSAgICB6bG8tPmJhc2VfZGlyLCB6bG8t
PmlkKTsKKwlpZiAoSVNfRVJSKHpsby0+ZGF0YV9kaXIpKSB7CisJCXJldCA9IFBUUl9FUlIo
emxvLT5kYXRhX2Rpcik7CisJCXByX3dhcm4oIkZhaWxlZCB0byBvcGVuIGRpcmVjdG9yeSAl
cy8ldSAoZXJyPSVkKVxuIiwKKwkJCXpsby0+YmFzZV9kaXIsIHpsby0+aWQsIHJldCk7CisJ
CWdvdG8gb3V0X2ZyZWVfYmFzZV9kaXI7CisJfQorCisJLyogVXNlIHRoZSBGUyBibG9jayBz
aXplIGFzIHRoZSBkZXZpY2Ugc2VjdG9yIHNpemUuICovCisJYmxvY2tfc2l6ZSA9IGZpbGVf
aW5vZGUoemxvLT5kYXRhX2RpciktPmlfc2ItPnNfYmxvY2tzaXplOworCWlmIChibG9ja19z
aXplID4gU1pfNEspIHsKKwkJcHJfd2FybigiVW5zdXBwb3J0ZWQgRlMgYmxvY2sgc2l6ZSAl
ZCBCID4gNDA5NlxuIiwKKwkJCWJsb2NrX3NpemUpOworCQlnb3RvIG91dF9jbG9zZV9kYXRh
X2RpcjsKKwl9CisJbGltLnBoeXNpY2FsX2Jsb2NrX3NpemUgPSBibG9ja19zaXplOworCWxp
bS5sb2dpY2FsX2Jsb2NrX3NpemUgPSBibG9ja19zaXplOworCisJLyoKKwkgKiBJZiB3ZSBh
bHJlYWR5IGhhdmUgem9uZSBmaWxlcywgd2UgYXJlIHJlc3RvcmluZyBhIGRldmljZSBjcmVh
dGVkIGJ5IGEKKwkgKiBwcmV2aW91cyBhZGQgb3BlcmF0aW9uLiBJbiB0aGlzIGNhc2UsIHps
b29wX2luaXRfem9uZSgpIHdpbGwgY2hlY2sKKwkgKiB0aGF0IHRoZSB6b25lIGZpbGVzIGFy
ZSBjb25zaXN0ZW50IHdpdGggdGhlIHpvbmUgY29uZmlndXJhdGlvbiBnaXZlbi4KKwkgKi8K
KwlyZXN0b3JlID0gemxvb3BfZGV2X2V4aXN0cyh6bG8pOworCWZvciAoaSA9IDA7IGkgPCBu
cl96b25lczsgaSsrKSB7CisJCXJldCA9IHpsb29wX2luaXRfem9uZSh6bG8sIGksIG9wdHMs
IHJlc3RvcmUpOworCQlpZiAocmV0KQorCQkJZ290byBvdXRfY2xvc2VfZmlsZXM7CisJfQor
CisJemxvLT50YWdfc2V0Lm9wcyA9ICZ6bG9vcF9tcV9vcHM7CisJemxvLT50YWdfc2V0Lm5y
X2h3X3F1ZXVlcyA9IG9wdHMtPm5yX3F1ZXVlczsKKwl6bG8tPnRhZ19zZXQucXVldWVfZGVw
dGggPSBvcHRzLT5xdWV1ZV9kZXB0aDsKKwl6bG8tPnRhZ19zZXQubnVtYV9ub2RlID0gTlVN
QV9OT19OT0RFOworCXpsby0+dGFnX3NldC5jbWRfc2l6ZSA9IHNpemVvZihzdHJ1Y3Qgemxv
b3BfY21kKTsKKwl6bG8tPnRhZ19zZXQuZHJpdmVyX2RhdGEgPSB6bG87CisKKwlyZXQgPSBi
bGtfbXFfYWxsb2NfdGFnX3NldCgmemxvLT50YWdfc2V0KTsKKwlpZiAocmV0KSB7CisJCXBy
X2VycigiYmxrX21xX2FsbG9jX3RhZ19zZXQgZmFpbGVkIChlcnI9JWQpXG4iLCByZXQpOwor
CQlnb3RvIG91dF9jbG9zZV9maWxlczsKKwl9CisKKwl6bG8tPmRpc2sgPSBibGtfbXFfYWxs
b2NfZGlzaygmemxvLT50YWdfc2V0LCAmbGltLCB6bG8pOworCWlmIChJU19FUlIoemxvLT5k
aXNrKSkgeworCQlwcl9lcnIoImJsa19tcV9hbGxvY19kaXNrIGZhaWxlZCAoZXJyPSVkKVxu
IiwgcmV0KTsKKwkJcmV0ID0gUFRSX0VSUih6bG8tPmRpc2spOworCQlnb3RvIG91dF9jbGVh
bnVwX3RhZ3M7CisJfQorCXpsby0+ZGlzay0+ZmxhZ3MgPSBHRU5IRF9GTF9OT19QQVJUOwor
CXpsby0+ZGlzay0+Zm9wcyA9ICZ6bG9vcF9mb3BzOworCXpsby0+ZGlzay0+cHJpdmF0ZV9k
YXRhID0gemxvOworCXNwcmludGYoemxvLT5kaXNrLT5kaXNrX25hbWUsICJ6bG9vcCVkIiwg
emxvLT5pZCk7CisJc2V0X2NhcGFjaXR5KHpsby0+ZGlzaywgKHU2NClsaW0uY2h1bmtfc2Vj
dG9ycyAqIHpsby0+bnJfem9uZXMpOworCisJaWYgKGJsa19yZXZhbGlkYXRlX2Rpc2tfem9u
ZXMoemxvLT5kaXNrKSkKKwkJZ290byBvdXRfY2xlYW51cF9kaXNrOworCisJcmV0ID0gYWRk
X2Rpc2soemxvLT5kaXNrKTsKKwlpZiAocmV0KSB7CisJCXByX2VycigiYWRkX2Rpc2sgZmFp
bGVkIChlcnI9JWQpXG4iLCByZXQpOworCQlnb3RvIG91dF9jbGVhbnVwX2Rpc2s7CisJfQor
CisJbXV0ZXhfbG9jaygmemxvb3BfY3RsX211dGV4KTsKKwl6bG8tPnN0YXRlID0gWmxvX2xp
dmU7CisJbXV0ZXhfdW5sb2NrKCZ6bG9vcF9jdGxfbXV0ZXgpOworCisJcHJfaW5mbygiQWRk
ZWQgZGV2aWNlICVkXG4iLCB6bG8tPmlkKTsKKworCXJldHVybiAwOworCitvdXRfY2xlYW51
cF9kaXNrOgorCXB1dF9kaXNrKHpsby0+ZGlzayk7CitvdXRfY2xlYW51cF90YWdzOgorCWJs
a19tcV9mcmVlX3RhZ19zZXQoJnpsby0+dGFnX3NldCk7CitvdXRfY2xvc2VfZmlsZXM6CisJ
Zm9yIChqID0gMDsgaiA8IGk7IGorKykgeworCQlzdHJ1Y3Qgemxvb3Bfem9uZSAqem9uZSA9
ICZ6bG8tPnpvbmVzW2pdOworCisJCWlmICghSVNfRVJSX09SX05VTEwoem9uZS0+ZmlsZSkp
CisJCQlmcHV0KHpvbmUtPmZpbGUpOworCX0KK291dF9jbG9zZV9kYXRhX2RpcjoKKwlmcHV0
KHpsby0+ZGF0YV9kaXIpOworb3V0X2ZyZWVfYmFzZV9kaXI6CisJa2ZyZWUoemxvLT5iYXNl
X2Rpcik7CitvdXRfZGVzdHJveV93b3JrcXVldWU6CisJZGVzdHJveV93b3JrcXVldWUoemxv
LT53b3JrcXVldWUpOworb3V0X2ZyZWVfaWRyOgorCW11dGV4X2xvY2soJnpsb29wX2N0bF9t
dXRleCk7CisJaWRyX3JlbW92ZSgmemxvb3BfaW5kZXhfaWRyLCB6bG8tPmlkKTsKKwltdXRl
eF91bmxvY2soJnpsb29wX2N0bF9tdXRleCk7CitvdXRfZnJlZV9kZXY6CisJa3ZmcmVlKHps
byk7CitvdXQ6CisJbW9kdWxlX3B1dChUSElTX01PRFVMRSk7CisJaWYgKHJldCA9PSAtRU5P
RU5UKQorCQlyZXQgPSAtRUlOVkFMOworCXJldHVybiByZXQ7Cit9CisKK3N0YXRpYyBpbnQg
emxvb3BfY3RsX3JlbW92ZShzdHJ1Y3Qgemxvb3Bfb3B0aW9ucyAqb3B0cykKK3sKKwlzdHJ1
Y3Qgemxvb3BfZGV2aWNlICp6bG87CisJaW50IHJldDsKKworCWlmICghKG9wdHMtPm1hc2sg
JiBaTE9PUF9PUFRfSUQpKSB7CisJCXByX2VycigiTm8gSUQgc3BlY2lmaWVkXG4iKTsKKwkJ
cmV0dXJuIC1FSU5WQUw7CisJfQorCisJcmV0ID0gbXV0ZXhfbG9ja19raWxsYWJsZSgmemxv
b3BfY3RsX211dGV4KTsKKwlpZiAocmV0KQorCQlyZXR1cm4gcmV0OworCisJemxvID0gaWRy
X2ZpbmQoJnpsb29wX2luZGV4X2lkciwgb3B0cy0+aWQpOworCWlmICghemxvIHx8IHpsby0+
c3RhdGUgPT0gWmxvX2NyZWF0aW5nKSB7CisJCXJldCA9IC1FTk9ERVY7CisJfSBlbHNlIGlm
ICh6bG8tPnN0YXRlID09IFpsb19kZWxldGluZykgeworCQlyZXQgPSAtRUlOVkFMOworCX0g
ZWxzZSB7CisJCWlkcl9yZW1vdmUoJnpsb29wX2luZGV4X2lkciwgemxvLT5pZCk7CisJCXps
by0+c3RhdGUgPSBabG9fZGVsZXRpbmc7CisJfQorCisJbXV0ZXhfdW5sb2NrKCZ6bG9vcF9j
dGxfbXV0ZXgpOworCWlmIChyZXQpCisJCXJldHVybiByZXQ7CisKKwlkZWxfZ2VuZGlzayh6
bG8tPmRpc2spOworCXB1dF9kaXNrKHpsby0+ZGlzayk7CisJYmxrX21xX2ZyZWVfdGFnX3Nl
dCgmemxvLT50YWdfc2V0KTsKKworCXByX2luZm8oIlJlbW92ZWQgZGV2aWNlICVkXG4iLCBv
cHRzLT5pZCk7CisKKwltb2R1bGVfcHV0KFRISVNfTU9EVUxFKTsKKworCXJldHVybiAwOwor
fQorCitzdGF0aWMgaW50IHpsb29wX3BhcnNlX29wdGlvbnMoc3RydWN0IHpsb29wX29wdGlv
bnMgKm9wdHMsIGNvbnN0IGNoYXIgKmJ1ZikKK3sKKwlzdWJzdHJpbmdfdCBhcmdzW01BWF9P
UFRfQVJHU107CisJY2hhciAqb3B0aW9ucywgKm8sICpwOworCXVuc2lnbmVkIGludCB0b2tl
bjsKKwlpbnQgcmV0ID0gMDsKKworCS8qIFNldCBkZWZhdWx0cy4gKi8KKwlvcHRzLT5tYXNr
ID0gMDsKKwlvcHRzLT5pZCA9IFpMT09QX0RFRl9JRDsKKwlvcHRzLT5jYXBhY2l0eSA9IFpM
T09QX0RFRl9aT05FX1NJWkUgKiBaTE9PUF9ERUZfTlJfWk9ORVM7CisJb3B0cy0+em9uZV9z
aXplID0gWkxPT1BfREVGX1pPTkVfU0laRTsKKwlvcHRzLT5ucl9jb252X3pvbmVzID0gWkxP
T1BfREVGX05SX0NPTlZfWk9ORVM7CisJb3B0cy0+bnJfcXVldWVzID0gWkxPT1BfREVGX05S
X1FVRVVFUzsKKwlvcHRzLT5xdWV1ZV9kZXB0aCA9IFpMT09QX0RFRl9RVUVVRV9ERVBUSDsK
KwlvcHRzLT5idWZmZXJlZF9pbyA9IFpMT09QX0RFRl9CVUZGRVJFRF9JTzsKKworCWlmICgh
YnVmKQorCQlyZXR1cm4gMDsKKworCS8qIFNraXAgbGVhZGluZyBzcGFjZXMgYmVmb3JlIHRo
ZSBvcHRpb25zLiAqLworCXdoaWxlIChpc3NwYWNlKCpidWYpKQorCQlidWYrKzsKKworCW9w
dGlvbnMgPSBvID0ga3N0cmR1cChidWYsIEdGUF9LRVJORUwpOworCWlmICghb3B0aW9ucykK
KwkJcmV0dXJuIC1FTk9NRU07CisKKwkvKiBQYXJzZSB0aGUgb3B0aW9ucywgZG9pbmcgb25s
eSBzb21lIGxpZ2h0IGludmFsaWQgdmFsdWUgY2hlY2tzLiAqLworCXdoaWxlICgocCA9IHN0
cnNlcCgmbywgIixcbiIpKSAhPSBOVUxMKSB7CisJCWlmICghKnApCisJCQljb250aW51ZTsK
KworCQl0b2tlbiA9IG1hdGNoX3Rva2VuKHAsIHpsb29wX29wdF90b2tlbnMsIGFyZ3MpOwor
CQlvcHRzLT5tYXNrIHw9IHRva2VuOworCQlzd2l0Y2ggKHRva2VuKSB7CisJCWNhc2UgWkxP
T1BfT1BUX0lEOgorCQkJaWYgKG1hdGNoX2ludChhcmdzLCAmb3B0cy0+aWQpKSB7CisJCQkJ
cmV0ID0gLUVJTlZBTDsKKwkJCQlnb3RvIG91dDsKKwkJCX0KKwkJCWJyZWFrOworCQljYXNl
IFpMT09QX09QVF9DQVBBQ0lUWToKKwkJCWlmIChtYXRjaF91aW50KGFyZ3MsICZ0b2tlbikp
IHsKKwkJCQlyZXQgPSAtRUlOVkFMOworCQkJCWdvdG8gb3V0OworCQkJfQorCQkJaWYgKCF0
b2tlbikgeworCQkJCXByX2VycigiSW52YWxpZCBjYXBhY2l0eVxuIik7CisJCQkJcmV0ID0g
LUVJTlZBTDsKKwkJCQlnb3RvIG91dDsKKwkJCX0KKwkJCW9wdHMtPmNhcGFjaXR5ID0KKwkJ
CQkoKHNlY3Rvcl90KXRva2VuICogU1pfMU0pID4+IFNFQ1RPUl9TSElGVDsKKwkJCWJyZWFr
OworCQljYXNlIFpMT09QX09QVF9aT05FX1NJWkU6CisJCQlpZiAobWF0Y2hfdWludChhcmdz
LCAmdG9rZW4pKSB7CisJCQkJcmV0ID0gLUVJTlZBTDsKKwkJCQlnb3RvIG91dDsKKwkJCX0K
KwkJCWlmICghdG9rZW4gfHwgdG9rZW4gPiBaTE9PUF9NQVhfWk9ORV9TSVpFX01CIHx8CisJ
CQkgICAgIWlzX3Bvd2VyX29mXzIodG9rZW4pKSB7CisJCQkJcHJfZXJyKCJJbnZhbGlkIHpv
bmUgc2l6ZSAldVxuIiwgdG9rZW4pOworCQkJCXJldCA9IC1FSU5WQUw7CisJCQkJZ290byBv
dXQ7CisJCQl9CisJCQlvcHRzLT56b25lX3NpemUgPQorCQkJCSgoc2VjdG9yX3QpdG9rZW4g
KiBTWl8xTSkgPj4gU0VDVE9SX1NISUZUOworCQkJYnJlYWs7CisJCWNhc2UgWkxPT1BfT1BU
X1pPTkVfQ0FQQUNJVFk6CisJCQlpZiAobWF0Y2hfdWludChhcmdzLCAmdG9rZW4pKSB7CisJ
CQkJcmV0ID0gLUVJTlZBTDsKKwkJCQlnb3RvIG91dDsKKwkJCX0KKwkJCWlmICghdG9rZW4p
IHsKKwkJCQlwcl9lcnIoIkludmFsaWQgem9uZSBjYXBhY2l0eVxuIik7CisJCQkJcmV0ID0g
LUVJTlZBTDsKKwkJCQlnb3RvIG91dDsKKwkJCX0KKwkJCW9wdHMtPnpvbmVfY2FwYWNpdHkg
PQorCQkJCSgoc2VjdG9yX3QpdG9rZW4gKiBTWl8xTSkgPj4gU0VDVE9SX1NISUZUOworCQkJ
YnJlYWs7CisJCWNhc2UgWkxPT1BfT1BUX05SX0NPTlZfWk9ORVM6CisJCQlpZiAobWF0Y2hf
dWludChhcmdzLCAmdG9rZW4pKSB7CisJCQkJcmV0ID0gLUVJTlZBTDsKKwkJCQlnb3RvIG91
dDsKKwkJCX0KKwkJCW9wdHMtPm5yX2NvbnZfem9uZXMgPSB0b2tlbjsKKwkJCWJyZWFrOwor
CQljYXNlIFpMT09QX09QVF9CQVNFX0RJUjoKKwkJCXAgPSBtYXRjaF9zdHJkdXAoYXJncyk7
CisJCQlpZiAoIXApIHsKKwkJCQlyZXQgPSAtRU5PTUVNOworCQkJCWdvdG8gb3V0OworCQkJ
fQorCQkJa2ZyZWUob3B0cy0+YmFzZV9kaXIpOworCQkJb3B0cy0+YmFzZV9kaXIgPSBwOwor
CQkJYnJlYWs7CisJCWNhc2UgWkxPT1BfT1BUX05SX1FVRVVFUzoKKwkJCWlmIChtYXRjaF91
aW50KGFyZ3MsICZ0b2tlbikpIHsKKwkJCQlyZXQgPSAtRUlOVkFMOworCQkJCWdvdG8gb3V0
OworCQkJfQorCQkJaWYgKCF0b2tlbikgeworCQkJCXByX2VycigiSW52YWxpZCBudW1iZXIg
b2YgcXVldWVzXG4iKTsKKwkJCQlyZXQgPSAtRUlOVkFMOworCQkJCWdvdG8gb3V0OworCQkJ
fQorCQkJb3B0cy0+bnJfcXVldWVzID0gbWluKHRva2VuLCBudW1fb25saW5lX2NwdXMoKSk7
CisJCQlicmVhazsKKwkJY2FzZSBaTE9PUF9PUFRfUVVFVUVfREVQVEg6CisJCQlpZiAobWF0
Y2hfdWludChhcmdzLCAmdG9rZW4pKSB7CisJCQkJcmV0ID0gLUVJTlZBTDsKKwkJCQlnb3Rv
IG91dDsKKwkJCX0KKwkJCWlmICghdG9rZW4pIHsKKwkJCQlwcl9lcnIoIkludmFsaWQgcXVl
dWUgZGVwdGhcbiIpOworCQkJCXJldCA9IC1FSU5WQUw7CisJCQkJZ290byBvdXQ7CisJCQl9
CisJCQlvcHRzLT5xdWV1ZV9kZXB0aCA9IHRva2VuOworCQkJYnJlYWs7CisJCWNhc2UgWkxP
T1BfT1BUX0JVRkZFUkVEX0lPOgorCQkJb3B0cy0+YnVmZmVyZWRfaW8gPSB0cnVlOworCQkJ
YnJlYWs7CisJCWNhc2UgWkxPT1BfT1BUX0VSUjoKKwkJZGVmYXVsdDoKKwkJCXByX3dhcm4o
InVua25vd24gcGFyYW1ldGVyIG9yIG1pc3NpbmcgdmFsdWUgJyVzJ1xuIiwgcCk7CisJCQly
ZXQgPSAtRUlOVkFMOworCQkJZ290byBvdXQ7CisJCX0KKwl9CisKKwlyZXQgPSAtRUlOVkFM
OworCWlmIChvcHRzLT5jYXBhY2l0eSA8PSBvcHRzLT56b25lX3NpemUpIHsKKwkJcHJfZXJy
KCJJbnZhbGlkIGNhcGFjaXR5XG4iKTsKKwkJZ290byBvdXQ7CisJfQorCisJaWYgKG9wdHMt
PnpvbmVfY2FwYWNpdHkgPiBvcHRzLT56b25lX3NpemUpIHsKKwkJcHJfZXJyKCJJbnZhbGlk
IHpvbmUgY2FwYWNpdHlcbiIpOworCQlnb3RvIG91dDsKKwl9CisKKwlyZXQgPSAwOworb3V0
OgorCWtmcmVlKG9wdGlvbnMpOworCXJldHVybiByZXQ7Cit9CisKK2VudW0geworCVpMT09Q
X0NUTF9BREQsCisJWkxPT1BfQ1RMX1JFTU9WRSwKK307CisKK3N0YXRpYyBzdHJ1Y3Qgemxv
b3BfY3RsX29wIHsKKwlpbnQJCWNvZGU7CisJY29uc3QgY2hhcgkqbmFtZTsKK30gemxvb3Bf
Y3RsX29wc1tdID0geworCXsgWkxPT1BfQ1RMX0FERCwJImFkZCIgfSwKKwl7IFpMT09QX0NU
TF9SRU1PVkUsCSJyZW1vdmUiIH0sCisJeyAtMSwJTlVMTCB9LAorfTsKKworc3RhdGljIHNz
aXplX3Qgemxvb3BfY3RsX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLCBjb25zdCBjaGFyIF9f
dXNlciAqdWJ1ZiwKKwkJCSAgICAgICBzaXplX3QgY291bnQsIGxvZmZfdCAqcG9zKQorewor
CXN0cnVjdCB6bG9vcF9vcHRpb25zIG9wdHMgPSB7IH07CisJc3RydWN0IHpsb29wX2N0bF9v
cCAqb3A7CisJY29uc3QgY2hhciAqYnVmLCAqb3B0c19idWY7CisJaW50IGksIHJldDsKKwor
CWlmIChjb3VudCA+IFBBR0VfU0laRSkKKwkJcmV0dXJuIC1FTk9NRU07CisKKwlidWYgPSBt
ZW1kdXBfdXNlcl9udWwodWJ1ZiwgY291bnQpOworCWlmIChJU19FUlIoYnVmKSkKKwkJcmV0
dXJuIFBUUl9FUlIoYnVmKTsKKworCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHpsb29w
X2N0bF9vcHMpOyBpKyspIHsKKwkJb3AgPSAmemxvb3BfY3RsX29wc1tpXTsKKwkJaWYgKCFv
cC0+bmFtZSkgeworCQkJcHJfZXJyKCJJbnZhbGlkIG9wZXJhdGlvblxuIik7CisJCQlyZXQg
PSAtRUlOVkFMOworCQkJZ290byBvdXQ7CisJCX0KKwkJaWYgKCFzdHJuY21wKGJ1Ziwgb3At
Pm5hbWUsIHN0cmxlbihvcC0+bmFtZSkpKQorCQkJYnJlYWs7CisJfQorCisJaWYgKGNvdW50
IDw9IHN0cmxlbihvcC0+bmFtZSkpCisJCW9wdHNfYnVmID0gTlVMTDsKKwllbHNlCisJCW9w
dHNfYnVmID0gYnVmICsgc3RybGVuKG9wLT5uYW1lKTsKKworCXJldCA9IHpsb29wX3BhcnNl
X29wdGlvbnMoJm9wdHMsIG9wdHNfYnVmKTsKKwlpZiAocmV0KSB7CisJCXByX2VycigiRmFp
bGVkIHRvIHBhcnNlIG9wdGlvbnNcbiIpOworCQlnb3RvIG91dDsKKwl9CisKKwlzd2l0Y2gg
KG9wLT5jb2RlKSB7CisJY2FzZSBaTE9PUF9DVExfQUREOgorCQlyZXQgPSB6bG9vcF9jdGxf
YWRkKCZvcHRzKTsKKwkJYnJlYWs7CisJY2FzZSBaTE9PUF9DVExfUkVNT1ZFOgorCQlyZXQg
PSB6bG9vcF9jdGxfcmVtb3ZlKCZvcHRzKTsKKwkJYnJlYWs7CisJZGVmYXVsdDoKKwkJcHJf
ZXJyKCJJbnZhbGlkIG9wZXJhdGlvblxuIik7CisJCXJldCA9IC1FSU5WQUw7CisJCWdvdG8g
b3V0OworCX0KKworb3V0OgorCWtmcmVlKG9wdHMuYmFzZV9kaXIpOworCWtmcmVlKGJ1Zik7
CisJcmV0dXJuIHJldCA/IHJldCA6IGNvdW50OworfQorCitzdGF0aWMgaW50IHpsb29wX2N0
bF9zaG93KHN0cnVjdCBzZXFfZmlsZSAqc2VxX2ZpbGUsIHZvaWQgKnByaXZhdGUpCit7CisJ
Y29uc3Qgc3RydWN0IG1hdGNoX3Rva2VuICp0b2s7CisJaW50IGk7CisKKwkvKiBBZGQgb3Bl
cmF0aW9uICovCisJc2VxX3ByaW50ZihzZXFfZmlsZSwgIiVzICIsIHpsb29wX2N0bF9vcHNb
MF0ubmFtZSk7CisJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoemxvb3Bfb3B0X3Rva2Vu
cyk7IGkrKykgeworCQl0b2sgPSAmemxvb3Bfb3B0X3Rva2Vuc1tpXTsKKwkJaWYgKCF0b2st
PnBhdHRlcm4pCisJCQlicmVhazsKKwkJaWYgKGkpCisJCQlzZXFfcHV0YyhzZXFfZmlsZSwg
JywnKTsKKwkJc2VxX3B1dHMoc2VxX2ZpbGUsIHRvay0+cGF0dGVybik7CisJfQorCXNlcV9w
dXRjKHNlcV9maWxlLCAnXG4nKTsKKworCS8qIFJlbW92ZSBvcGVyYXRpb24gKi8KKwlzZXFf
cHV0cyhzZXFfZmlsZSwgemxvb3BfY3RsX29wc1sxXS5uYW1lKTsKKwlzZXFfcHV0cyhzZXFf
ZmlsZSwgIiBpZD0lZFxuIik7CisKKwlyZXR1cm4gMDsKK30KKworc3RhdGljIGludCB6bG9v
cF9jdGxfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZSkKK3sK
KwlmaWxlLT5wcml2YXRlX2RhdGEgPSBOVUxMOworCXJldHVybiBzaW5nbGVfb3BlbihmaWxl
LCB6bG9vcF9jdGxfc2hvdywgTlVMTCk7Cit9CisKK3N0YXRpYyBpbnQgemxvb3BfY3RsX3Jl
bGVhc2Uoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUpCit7CisJcmV0
dXJuIHNpbmdsZV9yZWxlYXNlKGlub2RlLCBmaWxlKTsKK30KKworc3RhdGljIGNvbnN0IHN0
cnVjdCBmaWxlX29wZXJhdGlvbnMgemxvb3BfY3RsX2ZvcHMgPSB7CisJLm93bmVyCQk9IFRI
SVNfTU9EVUxFLAorCS5vcGVuCQk9IHpsb29wX2N0bF9vcGVuLAorCS5yZWxlYXNlCT0gemxv
b3BfY3RsX3JlbGVhc2UsCisJLndyaXRlCQk9IHpsb29wX2N0bF93cml0ZSwKKwkucmVhZAkJ
PSBzZXFfcmVhZCwKK307CisKK3N0YXRpYyBzdHJ1Y3QgbWlzY2RldmljZSB6bG9vcF9taXNj
ID0geworCS5taW5vcgkJPSBNSVNDX0RZTkFNSUNfTUlOT1IsCisJLm5hbWUJCT0gInpsb29w
LWNvbnRyb2wiLAorCS5mb3BzCQk9ICZ6bG9vcF9jdGxfZm9wcywKK307CisKK3N0YXRpYyBp
bnQgX19pbml0IHpsb29wX2luaXQodm9pZCkKK3sKKwlpbnQgcmV0OworCisJcmV0ID0gbWlz
Y19yZWdpc3Rlcigmemxvb3BfbWlzYyk7CisJaWYgKHJldCkgeworCQlwcl9lcnIoIkZhaWxl
ZCB0byByZWdpc3RlciBtaXNjIGRldmljZTogJWRcbiIsIHJldCk7CisJCXJldHVybiByZXQ7
CisJfQorCXByX2luZm8oIk1vZHVsZSBsb2FkZWRcbiIpOworCisJcmV0dXJuIDA7Cit9CisK
K3N0YXRpYyB2b2lkIF9fZXhpdCB6bG9vcF9leGl0KHZvaWQpCit7CisJbWlzY19kZXJlZ2lz
dGVyKCZ6bG9vcF9taXNjKTsKKwlpZHJfZGVzdHJveSgmemxvb3BfaW5kZXhfaWRyKTsKK30K
KworbW9kdWxlX2luaXQoemxvb3BfaW5pdCk7Cittb2R1bGVfZXhpdCh6bG9vcF9leGl0KTsK
KworTU9EVUxFX0RFU0NSSVBUSU9OKCJab25lZCBsb29wYmFjayBkZXZpY2UiKTsKK01PRFVM
RV9MSUNFTlNFKCJHUEwiKTsKLS0gCjIuNDguMQoK

--------------FXrC0bw5CzgNKC75swESoV8z--
