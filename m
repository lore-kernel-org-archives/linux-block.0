Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: Add block level changes for inline encryption
To: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>,
 Jens Axboe "<axboe@kernel.dk>;" Hannes Reinecke "<hare@suse.com>;" Johannes
 Thumshirn "<jthumshirn@suse.de>;" Omar Sandoval "<osandov@fb.com>;" Mike
 Snitzer "<snitzer@redhat.com>;" Shaohua Li "<shli@fb.com>;" Bart Van Assche
 "<bart.vanassche@wdc.com>" ";" Keith Busch "<keith.busch@intel.com>;" Ming
 Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org,
 "linux-kernel@vger.kernel.org;" Manjunath M Bettegowda
 "<manjumb@synopsys.com>;" Prabu Thangamuthu "<prabut@synopsys.com>;" Tejas
 Joglekar "<joglekar@synopsys.com>;" Joao Pinto <Joao.Pinto@synopsys.com>
References: <d3624fab-e6fc-f14d-c780-db703c809068@synopsys.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <77544032-b6ff-bc5e-9fec-666e66b2cc70@kernel.dk>
Date: Mon, 28 May 2018 09:54:30 -0600
MIME-Version: 1.0
In-Reply-To: <d3624fab-e6fc-f14d-c780-db703c809068@synopsys.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/28/18 7:43 AM, Ladvine D Almeida wrote:
> 
> This patch introduces new variable under bio structure to
> facilitate inline encryption. This variable is used to
> associate I/O requests to crypto information.

Hard no on this, for two reasons:

1) Any additions to struct bio are scrutinized heavily and
   need strong justification.

2) Without an actual use case, any change is always denied.
   This is just a stand-alone patch.

On top of that, you have it inside BLK_CGROUP, which is
probably not what you want.

-- 
Jens Axboe
