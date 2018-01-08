Return-Path: <holger@applied-asynchrony.com>
Subject: Re: [PATCH 2/8] blk-mq: protect completion path with RCU
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
To: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, jack@suse.cz,
 clm@fb.com, jbacik@fb.com
Cc: kernel-team@fb.com, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, peterz@infradead.org,
 jianchao.w.wang@oracle.com, Bart.VanAssche@wdc.com,
 linux-block@vger.kernel.org
References: <20180108191542.379478-1-tj@kernel.org>
 <20180108191542.379478-3-tj@kernel.org>
 <774b9fa0-c1f9-f528-09c3-2f3bd67e0fd5@applied-asynchrony.com>
 <93157cfd-7c3c-c260-14e2-25784fe43314@kernel.dk>
 <7b22068e-85a5-06e0-c699-d1e970bbb3a6@kernel.dk>
 <229f2475-733d-d20a-ccef-6f2c0c5ae7b7@applied-asynchrony.com>
Message-ID: <44929fcd-05eb-f67d-e9dc-14f7f6c02c72@applied-asynchrony.com>
Date: Tue, 9 Jan 2018 00:33:35 +0100
MIME-Version: 1.0
In-Reply-To: <229f2475-733d-d20a-ccef-6f2c0c5ae7b7@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 01/09/18 00:27, Holger Hoffstätte wrote:
> On 01/08/18 23:55, Jens Axboe wrote:
>> the good old
>>
>> int srcu_idx = srcu_idx;
>>
>> should get the job done.
> 
> (Narrator: It didn't.)

Narrator: we retract our previous statement and apologize for the
confusion. It works fine when you correctly replace all occurrences,
not just one. <:)

Holger
