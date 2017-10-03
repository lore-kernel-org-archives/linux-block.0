Return-Path: <paolo.bonzini@gmail.com>
Return-Path: <paolo.bonzini@gmail.com>
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH] block: drop "sending ioctl to a partition" message
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
References: <1506005362-13429-1-git-send-email-pbonzini@redhat.com>
Message-ID: <019433fb-9a89-4ef9-6d76-a817a2f52a0f@redhat.com>
Date: Tue, 3 Oct 2017 18:22:23 +0200
MIME-Version: 1.0
In-Reply-To: <1506005362-13429-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 21/09/2017 16:49, Paolo Bonzini wrote:
> After the first few months, the message has not led to many bug reports.
> It's been almost five years now, and in practice the main source of
> it seems to be MTIOCGET that someone is using to detect tape devices.
> While we could whitelist it just like CDROM_GET_CAPABILITY, this patch
> just removes the message altogether.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Ping (with fixed email address for Jens)...

Paolo
